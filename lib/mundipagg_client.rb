# frozen_string_literal: true

require "active_interaction"
require_relative "mundipagg_client/version"
require "mundipagg_client/mundipagg_base"
require "mundipagg_client/configuration"

require "mundipagg_client/operations/customers/create"
require "mundipagg_client/operations/customers/retrieve"
require "mundipagg_client/operations/customers/update"

require "mundipagg_client/operations/credit_cards/create"
require "mundipagg_client/operations/credit_cards/retrieve"
require "mundipagg_client/operations/credit_cards/update"
require "mundipagg_client/operations/credit_cards/delete"
require "mundipagg_client/operations/credit_cards/renew"

require "mundipagg_client/operations/charges/create"
require "mundipagg_client/operations/charges/delete"


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
