# frozen_string_literal: true

require "spec_helper"
require "mundipagg_client/operations/charges/create"

RSpec.describe MundipaggClient::Operations::Charges::Create do
  describe "#execute", vcr: true do
    before(:each) do
      MundipaggClient::MundipaggClientConfiguration.configure do |config|
        config.api_key = "sk_test_123"
      end
    end

    subject { described_class.run(params: params) }

    context "success" do
      context "with new card" do
        let(:params) do
          {
            amount: 10000,
            customer_id: "cus_rXZgoqjFwtj5GODx",
            statement_descriptor: "Padre Paulo Ricardo",
            card_number: "4000000000000010",
            card_exp_month: "10",
            card_exp_year: "30",
            card_cvv: "123",
            card_holder_name: "Anchieta S Junior",
            card_holder_document: "355.587.570-19"
          }
        end

        it "creates a charge with a new credit card on mundipagg" do
          expect(subject.result["status"]).to eq "paid"
          expect(subject.result["last_transaction"]["installments"]).to eq 1
          expect(subject.result["last_transaction"]["status"]).to eq "captured"
          expect(subject.result["last_transaction"]["card"]["id"]).to eq "card_7pMRljjC9oh38QZK"
        end
      end

      context "with an existing card" do
        let(:params) do
          {
            amount: 1000,
            customer_id: "card_ZeL9P5mUp1CBPWB1",
            statement_descriptor: "Padre Paulo Ricardo",
            installments: 1,
            card_id: "card_ZeL9P5mUp1CBPWB1"
          }
        end

        it "creates a charge on mundipagg" do
          expect(subject.result["status"]).to eq "paid"
          expect(subject.result["last_transaction"]["installments"]).to eq 4
          expect(subject.result["last_transaction"]["status"]).to eq "captured"
          expect(subject.result["last_transaction"]["card"]["id"]).to eq "card_ZeL9P5mUp1CBPWB1"
        end
      end
    end

    context "failure" do
      let(:params) do
        {
          amount: 1000,
          customer_id: "card_123123",
          statement_descriptor: "Padre Paulo Ricardo",
          installments: 1,
          card_id: "card_1231231"
        }
      end

      it "raises an Invalid Mundipagg Operation error" do
        expect { subject }.to raise_error(
          RuntimeError,
          "MundipaggClientError on charge_create, message: Customer not found., id: card_123123"
        )
      end
    end
  end
end
