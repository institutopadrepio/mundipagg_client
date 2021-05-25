# frozen_string_literal: true

module MundipaggClient
  module Operations
    module CreditCards
      class Update < MundipaggClient::MundipaggBase
        string :customer_id
        string :card_id
        hash :params do
          string :exp_month
          string :exp_year
          string :holder_name
          string :holder_document
        end

        def execute
          raise "Invalid Mundipagg operation" unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.put("#{BASE_URL}/customers/#{customer_id}/cards/#{card_id}") do |req|
            req.body = credit_card_params.to_json
          end
        end

        def credit_card_params
          {
            exp_month: params[:exp_month],
            exp_year: params[:exp_year],
            holder_name: sanitize_names(params[:holder_name]),
            holder_document: sanitize_numbers(params[:holder_document])
          }
        end
      end
    end
  end
end
