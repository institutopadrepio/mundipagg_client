# frozen_string_literal: true

module MundipaggClient
  module Operations
    module Customers
      class Create < MundipaggClient::MundipaggBase
        hash :params do
          string :name
          string :email
          string :document, default: nil
        end

        def execute
          raise "Invalid Mundipagg operation" unless request.success?

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
