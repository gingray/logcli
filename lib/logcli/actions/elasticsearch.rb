require 'elasticsearch'
require 'json'

module Logcli
  module Actions
    class Elasticsearch
      attr_reader :filenames, :buffer, :id, :total_records
      BULK_SIZE = 100
      INDEX_NAME = 'log-index'.freeze
      DEFAULT_URL = 'http://localhost:9201'.freeze

      def initialize opts
        @filenames = opts.fetch(:filenames)
        @buffer = []
        @id = 1
        @total_records = 0
      end

      def call
        filenames.each do |filename|
          File.open(filename).each do |line|
            @buffer << line
            if @buffer.count > BULK_SIZE
              flush
            end
          end
        end
        if @buffer.count > 0
          flush
        end
      end

      private

      def flush
        payload = @buffer.flat_map do |item|
          hash = JSON.parse(item)
          @id += 1
          @total_records += 1
          [
              { index: { _index: INDEX_NAME, _type: 'mytype', _id: @id } },
              hash
          ]
        end
        client.bulk body: payload
        puts "records uploaded #{@total_records}"
        @buffer = []
      end

      def client
        @client ||= ::Elasticsearch::Client.new url: DEFAULT_URL, log: true
      end
    end
  end
end
