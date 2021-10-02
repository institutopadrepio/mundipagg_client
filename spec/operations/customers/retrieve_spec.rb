# frozen_string_literal: true

require "spec_helper"
require "mundipagg_client/operations/customers/retrieve"

RSpec.describe MundipaggClient::Operations::Customers::Retrieve do
  describe "#execute", vcr: true do
    before(:each) do
      MundipaggClient::MundipaggClientConfiguration.configure do |config|
        config.api_key = "sk_test_123"
      end
    end

    subject { described_class.run(customer_id: customer_id) }

    context "success" do
      let(:customer_id) { "cus_rXZgoqjFwtj5GODx" }

      let(:expected_result) do
        {
          "id"=>"cus_rXZgoqjFwtj5GODx",
          "name"=>"Anchieta Junior",
          "email"=>"zemaria@escriva.com",
          "document"=>"03689994595",
          "type"=>"individual",
          "delinquent"=>false,
          "created_at"=>"2021-05-13T15:11:30Z",
          "updated_at"=>"2021-05-13T15:11:30Z",
          "phones"=>{}
        }
      end

      it "retrieves a customer" do
        expect(subject.result).to eq expected_result
      end
    end

    context "failure" do
      let(:customer_id) { "cus_ahsdjgasdhgh" }

      it "returns nil when no customer was found" do
        expect { subject }.to raise_error(
          RuntimeError,
          "MundipaggClientError on customer_retrieve, message: Customer not found., id: cus_ahsdjgasdhgh"
        )
      end
    end
  end
end
