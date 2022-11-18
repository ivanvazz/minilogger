module Minilogger
  module Fileable
    def log_directory?
      unless Dir.exists?(LOG_RELATIVE_PATH)
        Dir.mkdir(LOG_RELATIVE_PATH)
      end
    end

    def log_file
      File.expand_path(DEFAULT_LOG_FILE, LOG_RELATIVE_PATH)
    end
  end
end