module Logcli
  module Actions
    class Download
      attr_accessor :remote_path, :local_path
      def initialize opts
        @remote_path = opts.fetch(:remote_path)
        @local_path = opts.fetch(:local_path)
      end

      def call scp
        generate_local_path
        scp.download(remote_path, (local_path || generate_local_path))
      end

      private

      def generate_local_path
        File.join Dir.pwd, File.basename(remote_path)
      end
    end
  end
end