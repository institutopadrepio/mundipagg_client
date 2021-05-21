# frozen_string_literal: true

require "pry"

module MundipaggClient
  module Operations
    module Charges
      class Delete < MundipaggClient::MundipaggBase
        string :charge_id

        def execute
          raise "Invalid Mundipagg operation" unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.delete("#{BASE_URL}/charges/#{charge_id}")
        end
      end
    end
  end
end
