# frozen_string_literal: true

module MundipaggClient
  module Operations
    module Customers
      class Create < MundipaggClient::MundipaggBase
        hash :params do
          string :amount
          string :customer_id
        end

        def execute
          raise "Invalid Mundipagg operation" unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.post(
            path: "/charges",
            headers: headers,
            body: customer_params.to_json
          )
        end

        def customer_params
          {}.tap do |hash|
            hash[:amount] = params[:amount]
            hash[:customer_id] = params[:customer_id]
            payment_params(hash)
            credit_card_params(hash)
          end
        end

        def payment_params(hash)
          hash[:payment] = {
            payment_method: "credit_card",
            credit_card: {
              capture: true,
              recurrence: true,
              installments: installments,
              statement_descriptor: "Padre Paulo Ricardo"
            }
          }
        end

        def credit_card_params(hash)
          if params[:card_id].present?
            hash[:payment][:credit_card][:card_id] = params[:card_id]
          else
            hash[:payment][:credit_card][:card] = {
              number: params[:credit_card_number],
              holder_name: params[:credit_card_holder_name],
              exp_month: params[:credit_card_exp_month],
              exp_year: params[:credit_card_exp_year],
              cvv: params[:credit_card_cvv]
            }
          end
        end

        def installments
          params[:installments] || 1
        end
      end
    end
  end
end
