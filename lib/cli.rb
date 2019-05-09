require "thor"
require 'logger'
module Logcli
  class CLI < Thor
    desc "fetch", "fetch logs from remote host"
    option :path, required: true, banner: '/home/app/logs'
    option :grep, required: true, banner: 'user@example.com'
    option :host, required: true, banner: '127.0.0.1'
    option :user, required: true, banner: 'app'
    option :local_path, banner: 'app'
    option :secret_key

    def fetch
      params = Logcli::Params::Session.new options
      ssh = Logcli::SSH.new params
      grep = Logcli::Actions::Grep.new params.action_params
      grep.call ssh
      scp = Logcli::SCP.new params
      download = Logcli::Actions::Download.new({remote_path: grep.tmp_path, local_path: params.local_path })
      download.call scp
    end

    desc "extract_json", "extract json lines through file"
    option :filenames, type: :array, required: true, banner: 'example1.log example2.log'
    option :verify, banner: 'true'

    def extract_json
      params = Logcli::Params::Json.new options
      json = Logcli::Actions::ExtractJson.new(params.parse_params)
      json.call
    end

    desc "elasticsearch", "push json file to elasticsearch instance"
    option :filenames, type: :array, required: true, banner: 'example1.json example2.json'
    option :verify, banner: 'true'

    def elasticsearch
      params = Logcli::Params::Elasticsearch.new options
      json = Logcli::Actions::Elasticsearch.new(params.parse_params)
      json.call
    end
  end
end
