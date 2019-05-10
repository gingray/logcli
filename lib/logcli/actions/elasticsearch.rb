require 'elasticsearch'
require 'json'

module Logcli
  module Actions
    class Elasticsearch
      attr_reader :filenames, :elasticsearch_url, :mapping_file, :buffer, :id, :total_records
      BULK_SIZE = 100
      INDEX_NAME = 'log-index'.freeze

      def initialize opts
        @filenames = opts.fetch(:filenames)
        @mapping_file = opts.fetch(:mapping_file)
        @elasticsearch_url = opts.fetch(:elasticsearch_url)
        @buffer = []
        @id = 1
        @total_records = 0
      end

      def call
        create_mapping if mapping_file

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
              { index: { _index: INDEX_NAME, _id: @id } },
              hash
          ]
        end
        client.bulk body: payload
        puts "records uploaded #{@total_records}"
        @buffer = []
      end

      def create_mapping
        payload = JSON.parse(File.read(mapping_file))
        client.indices.create index: INDEX_NAME, body: payload
      end

      def client
        @client ||= ::Elasticsearch::Client.new url: elasticsearch_url, log: true
      end
    end
  end
end
