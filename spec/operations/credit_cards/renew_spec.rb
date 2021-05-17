# frozen_string_literal: true

require "spec_helper"
require "mundipagg_client/operations/credit_cards/renew"

RSpec.describe MundipaggClient::Operations::CreditCards::Renew do
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
          "id"=>"card_blRaGElCr5uQzD4N"
        }
      end

      it "renews a credit card" do
        expect(subject.result["id"]).to eq "card_blRaGElCr5uQzD4N"
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
