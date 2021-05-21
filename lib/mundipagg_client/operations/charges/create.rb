# frozen_string_literal: true

require "pry"

module MundipaggClient
  module Operations
    module Charges
      class Create < MundipaggClient::MundipaggBase
        hash :params do
          integer :amount
          string :customer_id
          string :card_id, default: nil
          string :statement_descriptor
          integer :installments, default: 1
          string :card_number, default: nil
          string :card_holder_name, default: nil
          string :card_exp_month, default: nil
          string :card_exp_year, default: nil
          string :card_cvv, default: nil
          string :card_cvv, default: nil
        end

        def execute
          raise "Invalid Mundipagg operation" unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.post("#{BASE_URL}/charges") do |req|
            req.body = charge_params.to_json
          end
        end

        def charge_params
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
              installments: params[:installments],
              statement_descriptor: params[:statement_descriptor]
            }
          }
        end

        def credit_card_params(hash)
          if params[:card_id].present?
            hash[:payment][:credit_card][:card_id] = params[:card_id]
          else
            hash[:payment][:credit_card][:card] = {
              number: params[:card_number],
              holder_name: params[:card_holder_name],
              exp_month: params[:card_exp_month],
              exp_year: params[:card_exp_year],
              cvv: params[:card_cvv]
            }
          end
        end
      end
    end
  end
end
