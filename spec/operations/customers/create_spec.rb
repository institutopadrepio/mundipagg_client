# frozen_string_literal: true

require "spec_helper"
require "mundipagg_client/operations/customers/create"

RSpec.describe MundipaggClient::Operations::Customers::Create do
  describe "#execute", vcr: true do
    before(:each) do
      MundipaggClient::MundipaggClientConfiguration.configure do |config|
        config.api_key = "sk_test_XKYQWVbUYrfK8E2A"
      end
    end

    context "success" do
      it "creates a customer on mundipagg" do
        operation = described_class.run(
          params: {
            result: true,
            name: "Anchieta"
          }
        )
        p operation.result
        # operation.result[:name].to eq "Anchieta"
      end
    end
  end
end
