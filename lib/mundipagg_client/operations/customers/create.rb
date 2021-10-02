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
          {
            name: params[:name],
            email: params[:email],
            type: "individual",
            document: formatted_document
          }
        end

        def formatted_document
          params[:document].present? ? params[:document].gsub(".", "").gsub("-", "") : nil
        end
      end
    end
  end
end
