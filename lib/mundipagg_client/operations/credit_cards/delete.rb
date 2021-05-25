# frozen_string_literal: true

module MundipaggClient
  module Operations
    module CreditCards
      class Delete < MundipaggClient::MundipaggBase
        string :customer_id
        string :card_id

        def execute
          raise "Invalid Mundipagg operation" unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.delete("#{BASE_URL}/customers/#{customer_id}/cards/#{card_id}")
        end
      end
    end
  end
end
