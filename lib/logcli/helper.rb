module Logcli
  class Helper
    def self.tmp_filename name=''
      filepart = name.gsub(/[^A-Za-z0-9@_-]/i, '')
      "grep_#{filepart}_#{Time.now.strftime('%d_%m_%Y')}.log"
    end
  end
end