require "rails_helper"

RSpec.describe "TherapistsRegistrations", type: :request do
  describe "Get #new" do
    context "login as admin" do
      let!(:admin) { create(:therapist, :admin) }

      it "show singup page" do
        sign_in admin
        get signup_path
        expect(response).to render_template :new
      end
    end

    context "login as user" do
      let!(:therapist) { create(:therapist) }

      it "redirect root_path" do
        sign_in therapist
        get signup_path
        expect(response).to redirect_to root_path
      end
    end

    context "not login" do
      it "redirect root_path" do
        get signup_path
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "Post #create" do
    context "login as admin" do
      let!(:admin) { create(:therapist, :admin) }
      let!(:therapist_params) { attributes_for(:therapist) }
      let!(:invalid_therapist_params) { attributes_for(:therapist, unique_id: "") }

      before do
        sign_in admin
      end

      context "if the parameter is valid" do
        it "is success to create therapist" do
          expect do
            post therapist_registration_path, params: { therapist: therapist_params }
          end.to change(Therapist, :count).by 1
        end
        it "redirect to root url" do
          post therapist_registration_path, params: { therapist: therapist_params }
          expect(response).to redirect_to root_path
          expect(flash[:notice]).to eq "アカウント登録を受け付けました。確認のメールをお送りします。"
        end
      end

      context "if the parameter is invalid" do
        it "is false to create therapits" do
          expect do
            post therapist_registration_path, params: { therapist: invalid_therapist_params }
          end.not_to change(Therapist, :count)
        end
        it "render signup page" do
          post therapist_registration_path, params: { user: invalid_therapist_params }
          expect(response).to render_template :new
        end
      end
    end

    context "login as therapist" do
      let!(:therapist) { create(:therapist) }
      let!(:therapist_params) { attributes_for(:therapist) }

      it "is false to create therapist" do
        sign_in therapist
        expect do
          post therapist_registration_path, params: { therapist: therapist_params }
        end.not_to change(Therapist, :count)
      end
    end

    context "not login" do
      let!(:therapist_params) { attributes_for(:therapist) }

      it "is false to create therapist" do
        expect do
          post therapist_registration_path, params: { therapist: therapist_params }
        end.not_to change(Therapist, :count)
      end
    end
  end
end
