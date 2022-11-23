module Minilogger
  module Loggable

    def format(message, severity, tags, reverse = false)
      message.reverse! if reverse

      if tags.nil?
        @message = "[#{severity}] #{message}"
      else
        tags_string = ""
        tags.each do |tag|
          tags_string << "[#{tag.upcase}]"
        end
        @message = "#{tags_string}[#{severity}] #{message}"
      end
    end

    def format_tag(tag)
      tag.to_s.gsub!(/^\"|\"?$/, "").upcase
    end

    def register(log)
      log_directory?

      File.open(log_file, 'a') do |file|
        if log.include?("\n")
          log.split("\n").each do |line|
            file.puts line
          end
        else
          file.puts log
        end
      end
    end
  end
end
