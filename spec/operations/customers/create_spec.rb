# frozen_string_literal: true

require "spec_helper"
require "mundipagg_client/operations/customers/create"

RSpec.describe MundipaggClient::Operations::Customers::Create do
  describe "#execute", vcr: true do
    before(:each) do
      MundipaggClient::MundipaggClientConfiguration.configure do |config|
        config.api_key = "sk_test_123"
      end
    end

    subject { described_class.run(params: params) }

    context "success" do
      let(:params) do
        {
          name: "Anchieta Junior",
          email: "zemaria@escriva.com",
          document: "036.899.945-95"
        }
      end

      let(:expected_result) do
        {
          "id" => "cus_rXZgoqjFwtj5GODx",
          "name" => "Anchieta Junior",
          "email" => "zemaria@escriva.com",
          "document" => "03689994595",
          "type" => "individual",
          "delinquent" => false,
          "created_at" => "2021-05-13T15:11:30Z",
          "updated_at" => "2021-05-13T15:11:30Z",
          "phones" => {}
        }
      end

      it "creates a customer on mundipagg" do
        expect(subject.result).to eq expected_result
        expect(subject.valid?).to eq true
      end
    end

    context "failure" do
      let(:params) do
        {
          name: "",
          email: "fulano@email.com",
          document: "123123"
        }
      end

      it "raises an Invalid Mundipagg Operation error" do
        expect { subject }.to raise_error(
          RuntimeError,
          "MundipaggClientError on customer_create, message: The request is invalid."
        )
      end
    end
  end
end
