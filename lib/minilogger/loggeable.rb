module Minilogger
  module Loggeable

    def format(message, severity, tags, reverse = false)
      if reverse == true
        msg = message.dup
        message = msg.reverse!
      end

      if tags.nil?
        @message = "[#{severity}] #{message}"
      else
        tags_string = ""
        tags.each do |tag|
          tag_up = tag.dup
          tag_up.upcase!
          tags_string << "[#{tag_up}]"
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
          log = log.split("\n")
          log.each do |line|
            file.puts line
          end
        else
          file.puts log
        end
      end
    end

  end
end
