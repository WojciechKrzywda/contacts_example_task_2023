require "rails_helper"

describe ContactsController do
  describe "GET index" do
    subject(:get_contacts) { get :index, format: :json }

    it "returns proper response" do
      get_contacts
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq("[]")
    end
  end

  describe "POST create" do
    subject(:post_contact) { post :create, params: params, format: :json }

    let(:params) { { contact: { email: "test@test.com", name: "Adam" } } }

    it "returns proper response code" do
      post_contact
      expect(response).to have_http_status(:created)
    end

    it "creates new contact" do
      expect { post_contact }.to change { Contact.count }.by(1)
    end
  end

  describe "POST mass_create" do
    subject(:post_mass_create) { post :mass_create, format: :json }

    let(:start_time) { Time.now.to_i }
    let(:end_time) { Time.now.to_i }

    # refactor needed
    xit "creates new contacts" do
      p "Start at: #{start_time}"

      expect { post_mass_create }.to change { Contact.count }.by(10_000)
      expect(response).to have_http_status(:created)

      p "End at: #{end_time}"
      p "Delta: #{end_time - start_time} seconds"
    end
  end

  describe "GET show" do
    subject(:show_contacts) { get :show, params: params, format: :json }

    let(:params) { { id: contact.id } }
    let(:contact) { create(:contact) }

    it "returns proper response" do
      show_contacts
      expect(response).to have_http_status(:ok)
    end
  end

  describe "PATCH update" do
    subject(:patch_contact) { patch :update, params: params, format: :json }

    let(:params) { { id: contact.id, contact: { email: "test2@test.com", name: "Adam" } } }
    let(:contact) { create(:contact) }

    it "returns proper response code" do
      patch_contact
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE destroy" do
    subject(:delete_contact) { delete :destroy, params: params, format: :json }

    let(:params) { { id: contact.id } }
    let(:contact) { create(:contact) }

    before { contact }

    it "returns proper response code" do
      delete_contact
      expect(response).to have_http_status(:no_content)
    end

    it "deletes contanct" do
      expect { delete_contact }.to change { Contact.count }.by(-1)
    end
  end
end
