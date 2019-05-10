module Logcli
  module Params
    class Elasticsearch
      FILENAMES = :filenames
      MAPPING_FILE = :mapping_file
      ELASTICSEARCH_URL = :elasticsearch_url
      OPTS = [FILENAMES, MAPPING_FILE, ELASTICSEARCH_URL].freeze
      attr_accessor(*OPTS)

      def initialize opts
        OPTS.each do |opt|
          val = opts.fetch opt, nil
          instance_variable_set "@#{opt}", val
        end
      end

      def parse_params
        { filenames: filenames, mapping_file: mapping_file, elasticsearch_url: elasticsearch_url }
      end
    end
  end
end
