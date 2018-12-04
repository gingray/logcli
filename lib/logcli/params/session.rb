module Logcli
  module Params
    class Session
      PATH = :path
      GREP = :grep
      HOST = :host
      USER = :user
      LOCAL_PATH = :local_path
      SECRET_KEY = :secret_key
      OPTS = [PATH, GREP, HOST, USER, SECRET_KEY, LOCAL_PATH].freeze
      attr_accessor(*OPTS)

      def initialize opts
        OPTS.each do |opt|
          val = opts.fetch opt, nil
          instance_variable_set "@#{opt}", val
        end
      end

      def ssh_args
        [host, user, {config: true}]
      end

      def scp_args
        [host, user, {config: true}]
      end

      def action_params
        {grep: grep, path: path}
      end
    end
  end
end