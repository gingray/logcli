module Logcli
  class SSH
    attr_accessor :params
    def initialize params
      @params = params
    end

    def execute! command
      result = ''
      Net::SSH.start(*params.ssh_args) do |ssh|
        result = ssh.exec! command
      end
      result
    end
  end
end