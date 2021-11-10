# frozen_string_literal: true
require 'pry'

module MundipaggClient
  module Operations
    module Charges
      class Create < MundipaggClient::MundipaggBase
        OPERATION_TYPE = "charge_create"

        hash :params do
          integer :amount
          string :customer_id
          # Payment type options accepted: credit_card or pix
          string :payment_type, default: "credit_card"
          string :card_id, default: nil
          string :statement_descriptor, default: nil
          integer :installments, default: 1
          string :card_number, default: nil
          string :card_holder_name, default: nil
          string :card_exp_month, default: nil
          string :card_exp_year, default: nil
          string :card_cvv, default: nil
          string :card_cvv, default: nil
          array :additional_information, default: nil
        end

        def execute
          unless request.success?
            raise request_error_message(
              request,
              OPERATION_TYPE,
              params[:customer_id]
            )
          end

          JSON.parse(request.body)
        end

        private

        def credit_card?
          params[:payment_type] == "credit_card"
        end

        def pix?
          params[:payment_type] == "pix"
        end

        def request
          @request ||= connection.post("#{BASE_URL}/charges") do |req|
            req.body = charge_params.to_json
          end
        end

        def charge_params
          {}.tap do |hash|
            hash[:amount] = params[:amount]
            hash[:customer_id] = params[:customer_id]
            hash[:payment] = {}
            hash[:payment][:payment_method] = params[:payment_type]
            credit_card_params(hash) if credit_card?
            pix_params(hash) if pix?
            additional_information(hash) if pix? && additional_information?
          end
        end

        def pix_params(hash)
          hash[:payment][:pix] = {
            expires_in: "259200" # 3 days in seconds
          }
        end

        def additional_information(hash)
          hash[:payment][:pix][:additional_information] = [
            {
              name: additional_information? ? additional_information_label : "",
              value: additional_information? ? additional_information_value : ""
            }
          ]
        end

        def additional_information?
          params[:additional_information].present?
        end

        def additional_information_label
          params[:additional_information].first
        end

        def additional_information_value
          params[:additional_information].last
        end

        def credit_card_params(hash)
          hash[:payment][:credit_card] = {
            capture: true,
            recurrence: true,
            installments: params[:installments],
            statement_descriptor: params[:statement_descriptor]
          }
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
