# frozen_string_literal: true

require "active_interaction"
require "mundipagg_client/mundipagg_base"
require "mundipagg_client/configuration"
require "mundipagg_client/application_formatter"
require "mundipagg_client/operations/customers/create"
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
