module Devise
  class MyLogger    
    def self.send(message, logger = Rails.logger)
      logger.add 0, "  \e[36mLDAP:\e[0m #{message}"
    end
  end
end