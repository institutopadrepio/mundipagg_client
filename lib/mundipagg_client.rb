# frozen_string_literal: true

require "require_all"
require "active_interaction"
require "mundipagg_client/mundipagg_base"
require "mundipagg_client/configuration"
require_all "lib/mundipagg_client/operations"

require_relative "mundipagg_client/version"

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
