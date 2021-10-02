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
