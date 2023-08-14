require "rails_helper"

describe GenerateContacts do
  describe "#call" do
    subject(:generate_contacts) { generate_call }

    context "with amount" do
      let(:generate_call) { described_class.new(amount).call }
      let(:amount) { 10 }

      it "generates array" do
        expect(generate_contacts).to be_a(Array)
      end

      it "generates arrayw with proper size" do
        expect(generate_contacts.size).to eq(amount)
      end
    end

    context "without amount" do
      let(:generate_call) { described_class.new.call }

      it "generates array" do
        expect(generate_contacts).to be_a(Array)
      end

      it "generates arrayw with default size" do
        expect(generate_contacts.size).to eq(10_000)
      end

      it "generates contacts with proper keyss" do
        expect(generate_contacts.first.keys).to eq(%i[name email])
      end

      it "generates proper contact email" do
        expect(generate_contacts.first[:email]).to include("@example.com")

      end
    end
  end
end
