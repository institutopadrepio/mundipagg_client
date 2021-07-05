# frozen_string_literal: true

require "spec_helper"
require "mundipagg_client/operations/charges/delete"

RSpec.describe MundipaggClient::Operations::Charges::Delete do
  describe "#execute", vcr: true do
    before(:each) do
      MundipaggClient::MundipaggClientConfiguration.configure do |config|
        config.api_key = "sk_test_XKYQWVbUYrfK8E2A"
      end
    end

    subject { described_class.run(charge_id: charge_id) }

    context "success" do
      let(:charge_id) { "ch_EWMVOEvi3ZFrx0ed" }

      it "deletes a charge" do
        expect(subject.result["id"]).to eq "ch_EWMVOEvi3ZFrx0ed"
        expect(subject.result["status"]).to eq "canceled"
        expect(subject.result["last_transaction"]["status"]).to eq "refunded"
      end

      context "partial refund" do
        subject { described_class.run(charge_id: charge_id, amount: amount) }
        let(:charge_id) { "ch_mBXQJ1miEiaJ2kjP" }
        let(:amount) { 100 }

        it "deletes a charge partially" do
          expect(subject.result["id"]).to eq "ch_mBXQJ1miEiaJ2kjP"
          expect(subject.result["canceled_amount"]).to eq 100
          expect(subject.result["last_transaction"]["status"]).to eq "refunded"
        end
      end
    end

    context "failure" do
      let(:charge_id) { "ch_1726387126" }

      it "raises an invalid Mundipagg operation error" do
        expect { subject }.to raise_error("Invalid Mundipagg operation")
      end
    end
  end
end
