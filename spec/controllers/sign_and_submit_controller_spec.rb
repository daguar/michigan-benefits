# frozen_string_literal: true

require "rails_helper"

RSpec.describe SignAndSubmitController, :member, type: :controller do
  let!(:current_app) do
    FactoryGirl.create(:snap_application, user: member)
  end

  let(:attributes) do
    { signature: current_app.signature }.with_indifferent_access
  end

  let(:step) do
    assigns(:step)
  end

  describe "#edit" do
    it "assigns the attributes to the step" do
      get :edit

      expect(attributes.keys.map { |attr| [attr, step.send(attr)] }.to_h).to eq attributes
    end
  end

  describe "#update" do
    let(:params) do
      { step: { signature: "Chiu Baka" } }
    end

    it "updates attributes" do
      expect do
        put :update, params: params
      end.to change {
        current_app.reload.attributes.slice(*attributes.keys)
      }.from("signature" => "Mr. RJD2").to("signature" => "Chiu Baka")
    end

    it "redirects" do
      put :update, params: params

      expect(response).to redirect_to root_path(anchor: "fold")
    end

    it "creates a PDF with the data" do
      app = current_app

      data = {
        applying_for_food_assistance: "Yes",
        full_name: app.name,
        birth_day: app.birthday.strftime("%d"),
        birth_month: app.birthday.strftime("%m"),
        birth_year: app.birthday.strftime("%Y"),
        street_address: app.street_address,
        city: app.city,
        county: app.county,
        state: app.state,
        zip: app.zip,
        signature: app.signature,
        signature_date: app.signed_at,
      }

      pdf_double = double(save: true)
      allow(Dhs1171Pdf).to receive(:new).with(data).and_return(pdf_double)

      put :update, params: { step: { signature: "Mr. RJD2" } }

      expect(pdf_double).to have_received(:save)
    end
  end
end
