# frozen_string_literal: true

require 'pry'

module MundipaggClient
  module Operations
    module CreditCards
      class Create < MundipaggClient::MundipaggBase
        OPERATION_TYPE = "credit_card_create"

        string :customer_id
        hash :params do
          string :number
          string :exp_month
          string :exp_year
          string :cvv
          string :holder_name
          string :holder_document, default: nil
        end

        def execute
          raise request_error_message(request, OPERATION_TYPE, customer_id) unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.post("#{BASE_URL}/customers/#{customer_id}/cards") do |req|
            req.body = credit_card_params.to_json
          end
        end

        def credit_card_params
          {
            number: sanitize_numbers(params[:number]),
            exp_month: params[:exp_month],
            exp_year: params[:exp_year],
            cvv: params[:cvv],
            holder_name: sanitize_names(params[:holder_name]),
            holder_document: (params[:holder_document].nil? ? nil : sanitize_numbers(params[:holder_document]))
          }
        end
      end
    end
  end
end
