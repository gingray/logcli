module Logcli
  class SCP
    attr_accessor :params
    def initialize params
      @params = params
    end

    def download remote_path, local_dest
      Net::SCP.start(*params.scp_args) do |scp|
        scp.download remote_path, local_dest do |ch, name, sent, total|
          puts "#{name}: #{sent}/#{total}"
        end
      end
    end
  end
end