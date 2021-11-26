# frozen_string_literal: true

require "spec_helper"
require "mundipagg_client/operations/customers/update"

RSpec.describe MundipaggClient::Operations::Customers::Update do
  describe "#execute", vcr: true do
    before(:each) do
      MundipaggClient::MundipaggClientConfiguration.configure do |config|
        config.api_key = "sk_test_123"
      end
    end

    subject { described_class.run(customer_id: customer_id, params: params) }

    context "success" do
      let(:customer_id) { "cus_zQ6j9Z0IDILrXo78" }
      let(:params) do
        {
          name: "José Anchieta Junior",
          email: "zemaria@escriva.com",
          document: "036.899.945-95",
          phone: "(74) 9999-0000"
        }
      end

      let(:expected_result) do
        {
          "id" => "cus_zQ6j9Z0IDILrXo78",
          "name" => "José Anchieta Junior",
          "email" => "zemaria@escriva.com",
          "document" => "03689994595",
          "type" => "individual",
          "delinquent" => false,
          "created_at" => "2021-11-26T21:01:57Z",
          "updated_at" => "2021-11-26T22:30:37Z",
          "phones" => {
            "home_phone" => { "area_code" => "74", "country_code" => "55", "number" => "99990000" }
          }
        }
      end

      it "updates a customer on mundipagg" do
        expect(subject.result).to eq expected_result
      end
    end

    context "failure" do
      let(:customer_id) { "cus_heauheUAHEuah" }
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
          "MundipaggClientError on customer_update, message: The request is invalid., id: cus_heauheUAHEuah"
        )
      end
    end
  end
end
