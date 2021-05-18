# frozen_string_literal: true

require "spec_helper"
require "mundipagg_client/operations/credit_cards/create"

RSpec.describe MundipaggClient::Operations::CreditCards::Create do
  describe "#execute", vcr: true do
    before(:each) do
      MundipaggClient::MundipaggClientConfiguration.configure do |config|
        config.api_key = "sk_test_XKYQWVbUYrfK8E2A"
      end
    end

    subject { described_class.run(customer_id: customer_id, params: params) }

    context "success" do
      let(:customer_id) { "cus_rXZgoqjFwtj5GODx" }
      let(:params) do
        {
          number: "4000 0000 0000 0010",
          exp_month: "10",
          exp_year: "30",
          cvv: "123",
          holder_name: "Anchieta S Junior",
          holder_document: "355.587.570-19"
        }
      end

      let(:expected_result) do
        {
          "id" => "card_blRaGElCr5uQzD4N",
          "first_six_digits" => "400000",
          "last_four_digits" => "0010",
          "brand" => "Visa",
          "holder_name" => "",
          "holder_document" => "35558757019",
          "exp_month" => 10,
          "exp_year" => 2030,
          "status" => "active",
          "type" => "credit",
          "created_at" => "2021-05-14T16:16:07Z",
          "updated_at" => "2021-05-14T16:16:07Z",
          "customer" => {
            "id" => "cus_rXZgoqjFwtj5GODx",
            "name" => "José Anchieta Junior",
            "email" => "zemaria@escriva.com",
            "document" => "03689994595",
            "type" => "individual",
            "delinquent" => false,
            "created_at" => "2021-05-13T15:11:30Z",
            "updated_at" => "2021-05-14T13:21:24Z",
            "phones" => {}
          }
        }
      end

      it "creates a credit card on mundipagg" do
        expect(subject.result).to eq expected_result
      end
    end

    context "failure" do
      let(:customer_id) { "cus_akjshdjkahskdhj" }
      let(:params) do
        {
          number: "4000 0000 0000 0010",
          exp_month: "10",
          exp_year: "30",
          cvv: "123",
          holder_name: "Anchieta S Junior",
          holder_document: "355.587.570-19"
        }
      end

      it "raises an Invalid Mundipagg Operation error" do
        expect { subject }.to raise_error("Invalid Mundipagg operation")
      end
    end
  end
end
