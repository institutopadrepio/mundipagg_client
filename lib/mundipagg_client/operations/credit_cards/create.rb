# frozen_string_literal: true

module MundipaggClient
  module Operations
    module CreditCards
      class Create < MundipaggClient::MundipaggBase
        string :customer_id
        hash :params do
          string :number
          string :exp_month
          string :exp_year
          string :cvv
          string :holder_name
          string :holder_document
        end

        def execute
          raise "Invalid Mundipagg operation" unless request.success?

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
            holder_name: sanitize_names(params[:holder_document]),
            holder_document: sanitize_numbers(params[:holder_document])
          }
        end
      end
    end
  end
end
