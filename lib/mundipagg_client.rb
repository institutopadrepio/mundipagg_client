# frozen_string_literal: true

require "require_all"
require "active_interaction"
require_all "./lib/mundipagg_client"

module MundipaggClient
  class MundipaggClientConfiguration
    def self.configuration
      @configuration ||= Configuration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end
