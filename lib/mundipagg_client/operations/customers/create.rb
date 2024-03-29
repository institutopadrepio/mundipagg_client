# frozen_string_literal: true

module MundipaggClient
  module Operations
    module Customers
      class Create < MundipaggClient::MundipaggBase
        OPERATION_TYPE = "customer_create"

        hash :params do
          string :name
          string :email
          string :document, default: nil
          string :phone, default: nil
        end

        def execute
          raise request_error_message(request, OPERATION_TYPE) unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.post("#{BASE_URL}/customers") do |req|
            req.body = customer_params.to_json
          end
        end

        def customer_params
          {}.tap do |hash|
            hash[:name] = params[:name]
            hash[:email] = params[:email]
            hash[:type] = "individual"
            hash[:document] = formatted_document
            hash[:phones] = phones if params[:phone].present?
          end
        end

        def phones
          {
            mobile_phone: {
              country_code: "55",
              number: phone_number,
              area_code: phone_area_code
            }
          }
        end

        def phone_number
          params[:phone].tr('^0-9', '')[2...-1]
        end

        def phone_area_code
          params[:phone].tr('^0-9', '')[0...2]
        end

        def formatted_document
          params[:document].present? ? params[:document].tr('^0-9', '') : nil
        end
      end
    end
  end
end
