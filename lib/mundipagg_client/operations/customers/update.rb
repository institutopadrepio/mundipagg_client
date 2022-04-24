# frozen_string_literal: true

module MundipaggClient
  module Operations
    module Customers
      class Update < MundipaggClient::MundipaggBase
        OPERATION_TYPE = "customer_update"

        string :customer_id
        hash :params do
          string :name
          string :email
          string :document
          string :phone, default: nil
          string :country, default: nil
        end

        def execute
          raise request_error_message(request, OPERATION_TYPE, customer_id) unless request.success?

          JSON.parse(request.body)
        end

        private

        def request
          @request ||= connection.put("#{BASE_URL}/customers/#{customer_id}") do |req|
            req.body = customer_params.to_json
          end
        end

        def customer_params
          {}.tap do |hash|
            hash[:name] = params[:name]
            hash[:email] = params[:email]
            hash[:type] = "individual"
            hash[:document] = formatted_document
            hash[:phones] = phones if params[:phone].present? && params[:country] == "280"
          end
        end

        def phones
          {
            "home_phone": {
              "country_code": "55",
              "number": phone_number,
              "area_code": phone_area_code
            }
          }
        end

        def phone_number
          params[:phone].split(")").last.gsub(" ", "").gsub("-", "")
        end

        def phone_area_code
          params[:phone].split(")").first.gsub("(", "")
        end

        def formatted_document
          params[:document].present? ? params[:document].gsub(".", "").gsub("-", "") : nil
        end
      end
    end
  end
end
