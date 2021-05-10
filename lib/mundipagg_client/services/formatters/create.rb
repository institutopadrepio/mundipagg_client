# frozen_string_literal: true

module MundipaggClient
  module Services
    module Formatters
      class Create < ApplicationFormatter
        def initialize(params)
          @params = params
        end
      end
    end
  end
end
