# frozen_string_literal: true

module MundipaggClient
  class MundipaggBase < ActiveInteraction::Base
    API_VERSION = "1"
    BASE_URL = "https://api.mundipagg.com/core/v#{API_VERSION}/"
  end
end
