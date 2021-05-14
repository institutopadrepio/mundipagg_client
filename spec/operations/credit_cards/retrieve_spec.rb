# frozen_string_literal: true

require "spec_helper"
require "mundipagg_client/operations/credit_cards/retrieve"

RSpec.describe MundipaggClient::Operations::CreditCards::Retrieve do
  describe "#execute", vcr: true do
    before(:each) do
      MundipaggClient::MundipaggClientConfiguration.configure do |config|
        config.api_key = "sk_test_XKYQWVbUYrfK8E2A"
      end
    end

    subject { described_class.run(customer_id: customer_id, card_id: card_id) }

    context "success" do
      let(:customer_id) { "cus_rXZgoqjFwtj5GODx" }
      let(:card_id) { "card_blRaGElCr5uQzD4N" }

      let(:expected_result) do
        {
          "id"=>"card_blRaGElCr5uQzD4N",
          "first_six_digits"=>"400000",
          "last_four_digits"=>"0010",
          "brand"=>"Visa",
          "holder_name"=>"",
          "holder_document"=>"35558757019",
          "exp_month"=>10,
          "exp_year"=>2030,
          "status"=>"active",
          "type"=>"credit",
          "created_at"=>"2021-05-14T16:16:07Z",
          "updated_at"=>"2021-05-14T16:16:07Z",
          "customer"=> {
            "id"=>"cus_rXZgoqjFwtj5GODx",
            "name"=>"José Anchieta Junior",
            "email"=>"zemaria@escriva.com",
            "document"=>"03689994595",
            "type"=>"individual",
            "delinquent"=>false,
            "created_at"=>"2021-05-13T15:11:30Z",
            "updated_at"=>"2021-05-14T13:21:24Z",
            "phones"=>{}
          }
        }
      end

      it "retrieves a credit card" do
        expect(subject.result).to eq expected_result
      end
    end

    context "failure" do
      let(:customer_id) { "cus_rXZgoqjFwtj5GODx" }
      let(:card_id) { "card_heuaheua" }

      it "returns nil when no customer was found" do
        expect { subject }.to raise_error("Invalid Mundipagg operation")
      end
    end
  end
end
