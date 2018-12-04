module Logcli
  module Actions
    class Grep
      COMMAND = 'grep'.freeze
      attr_accessor :grep, :path
      attr_reader :tmp_path

      def initialize opts
        @grep = opts.fetch(:grep)
        @path = opts.fetch(:path)
      end

      def call ssh
        cmd = "#{COMMAND} -rni \"#{grep}\" #{path} > #{tmp_path}"
        puts "[grep] start: [#{cmd}]"
        ssh.execute! cmd
        puts "[grep] finish: [#{cmd}]"
      end

      def tmp_path
        @tmp_path ||= begin
          filename = Logcli::Helper.tmp_filename grep
          @tmp_path = "/tmp/#{filename}"
        end
      end

      def self.call opts
        grep = new opts
        grep.call
      end
    end
  end
end