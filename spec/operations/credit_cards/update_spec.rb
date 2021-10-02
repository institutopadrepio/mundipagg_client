# frozen_string_literal: true

require "pry"
require "spec_helper"
require "mundipagg_client/operations/credit_cards/update"

RSpec.describe MundipaggClient::Operations::CreditCards::Update do
  describe "#execute", vcr: true do
    before(:each) do
      MundipaggClient::MundipaggClientConfiguration.configure do |config|
        config.api_key = "sk_test_123"
      end
    end

    subject {
      described_class.run(
        customer_id: customer_id,
        card_id: card_id,
        params: params
      )
    }

    context "success" do
      let(:customer_id) { "cus_rXZgoqjFwtj5GODx" }
      let(:card_id) { "card_blRaGElCr5uQzD4N" }
      let(:params) do
        {
          exp_month: "11",
          exp_year: "30",
          holder_name: "Anchieta Santos Junior",
          holder_document: "355.587.570-19"
        }
      end

      let(:expected_result) do
        {
          "id": "card_blRaGElCr5uQzD4N",
          "status": "active",
          "type": "credit",
          "customer": {
            "id": "cus_rXZgoqjFwtj5GODx",
            "name": "José Anchieta Junior"
          }
        }
      end

      it "updates a credit card on mundipagg" do
        expect(subject.result["id"]).to eq "card_blRaGElCr5uQzD4N"
        expect(subject.result["status"]).to eq "active"
        expect(subject.result["customer"]["id"]).to eq "cus_rXZgoqjFwtj5GODx"
      end
    end

    context "failure" do
      let(:customer_id) { "cus_akjshdjkahskdhj" }
      let(:card_id) { "card_ahsueahwuseh" }
      let(:params) do
        {
          exp_month: "10",
          exp_year: "30",
          holder_name: "Anchieta S Junior",
          holder_document: "355.587.570-19"
        }
      end

      it "raises an Invalid Mundipagg Operation error" do
        expect { subject }.to raise_error(
          RuntimeError,
          "MundipaggClientError on credit_card_update, message: The request is invalid., id: card_ahsueahwuseh"
        )
      end
    end
  end
end
