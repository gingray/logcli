module Logcli
  module Actions
    class ExtractJson
      attr_reader :filenames
      def initialize opts
        @filenames = opts.fetch(:filenames)
      end

      def call
        filenames.each do |filename|
          outfile = generate_out_filename filename
          File.open outfile, 'w' do |out|
            File.open(filename).each do |line|
              out_line = process line
              out.puts out_line if out_line
            end
          end
        end
      end
      
      private

      def process line
        match = line.match /(\{.*\})/
        return nil unless match
        match[1]
      end

      def generate_out_filename filename
        dir = File.dirname(filename)
        name = File.basename(filename, ".*")
        ext= File.extname(filename)
        File.join dir, "#{name}_json#{ext}"
      end
    end
  end
end