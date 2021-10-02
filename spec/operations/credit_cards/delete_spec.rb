# frozen_string_literal: true

require "spec_helper"
require "mundipagg_client/operations/credit_cards/delete"

RSpec.describe MundipaggClient::Operations::CreditCards::Delete do
  describe "#execute", vcr: true do
    before(:each) do
      MundipaggClient::MundipaggClientConfiguration.configure do |config|
        config.api_key = "sk_test_123"
      end
    end

    subject { described_class.run(customer_id: customer_id, card_id: card_id) }

    context "success" do
      let(:customer_id) { "cus_Ey50mGqF8Fej8RGq" }
      let(:card_id) { "card_AJzkyPZuMuv4n7V3" }

      let(:expected_result) do
        {
          "id": "card_AJzkyPZuMuv4n7V3",
          "holder_name": "Mailson Araujo",
          "status": "deleted",
          "customer": {
            "id": "cus_Ey50mGqF8Fej8RGq"
          }
        }
      end

      it "deletes a credit card" do
        expect(subject.result["id"]).to eq "card_AJzkyPZuMuv4n7V3"
        expect(subject.result["status"]).to eq "deleted"
        expect(subject.result["customer"]["id"]).to eq "cus_Ey50mGqF8Fej8RGq"
      end
    end

    context "failure" do
      let(:customer_id) { "cus_rXZgoqjFwtj5GODx" }
      let(:card_id) { "card_heuaheua" }

      it "returns nil when no customer was found" do
        # MundipaggClientError on operation_type, message: something, id: id
        expect { subject }.to raise_error(
          RuntimeError, "MundipaggClientError on credit_card_delete, message: Card not found., id: card_heuaheua"
        )
      end
    end
  end
end
