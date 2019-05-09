module Logcli
  module Params
    class Elasticsearch
      FILENAMES = :filenames
      OPTS = [FILENAMES].freeze
      attr_accessor(*OPTS)

      def initialize opts
        OPTS.each do |opt|
          val = opts.fetch opt, nil
          instance_variable_set "@#{opt}", val
        end
      end

      def parse_params
        { filenames: filenames }
      end
    end
  end
end
