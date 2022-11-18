module Minilogger
  class MyReverseLogger < MyLogger

    def info(message)
      logging(message, INFO)
    end

    def warn(message)
      logging(message, WARN)
    end

    def error(message)
      logging(message, ERROR)
    end

    def logging(message, severity)
      log = format(message,severity, @tags,true)
      register(log)
      return log
    end
  end
end
