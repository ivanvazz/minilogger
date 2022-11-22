require_relative "minilogger/version"
require_relative "minilogger/fileable"
require_relative "minilogger/loggable"
require_relative "minilogger/severity"

module Minilogger
  LOG_RELATIVE_PATH = './log'
  DEFAULT_LOG_FILE = 'dev.log'
  EOL = "\n"

  class MyLogger
    include Severity
    include Fileable
    include Loggable

    attr_accessor :message, :level, :info_size, :warn_size, :error_size, :info, :warn,
                  :error, :buffered_info_log, :buffered_warn_log, :buffered_error_log, :tags

    def initialize(**params)
      unless params.nil?
        @info = @info_size = params.fetch(:info_size, nil)
        @warn = @warn_size = params.fetch(:warn_size, nil)
        @error = @error_size = params.fetch(:error_size, nil)
        @tags = params.fetch(:tags, nil)
      end

      @buffered_info_log = [] if @info
      @buffered_warn_log = [] if @warn
      @buffered_error_log = [] if @error
    end

    def logging(log)
      register(log)
      return log
    end

    def info(message)
      log = format(message, INFO, @tags)
      if @info.nil?
        logging(log)
      else
        @buffered_info_log << log
        @info_size -= 1
        if @info_size > 0
          return nil
        else
          log = @buffered_info_log.join(EOL)
          register(log)
          @info_size = @info
          @buffered_info_log = []
          return log
        end
      end
    end

    def warn(message)
      log = format(message, WARN, @tags)
      if @warn.nil?
        logging(log)
      else
        @buffered_warn_log << log
        @warn_size -= 1
        if @warn_size > 0
          return nil
        else
          log = @buffered_warn_log.join(EOL)
          register(log)
          @warn_size = @warn
          @buffered_warn_log = []
          return log
        end
      end
    end

    def error(message)
      log = format(message, ERROR, @tags)
      if @error.nil?
        logging(log)
      else
        @buffered_error_log << log
        @error_size -= 1
        if @error_size > 0
          return nil
        else
          log = @buffered_error_log.join(EOL)
          register(log)
          @error_size = @error
          @buffered_error_log = []
          return log
        end
      end
    end
  end
end
