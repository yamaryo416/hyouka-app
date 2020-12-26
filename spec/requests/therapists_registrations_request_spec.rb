require "rails_helper"

RSpec.describe "TherapistsRegistrations", type: :request do
  describe "#new" do
    context "login as admin" do
      let!(:admin) { create(:therapist, :admin) }

      it "show singup page" do
        sign_in admin
        get signup_path
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      let!(:therapist) { create(:therapist) }

      it "redirect to root url" do
        sign_in therapist
        get signup_path
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to root url" do
        get signup_path
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "#create" do
    context "login as admin" do
      let!(:admin) { create(:therapist, :admin) }
      let!(:therapist_params) { attributes_for(:therapist) }
      let!(:invalid_therapist_params) do
        attributes_for(:therapist, unique_id: "", first_name: "", last_name: "")
      end

      before do
        sign_in admin
      end

      context "if the parameter is valid" do
        it "is success to create therapist" do
          expect do
            post therapist_registration_path, params: {
              therapist: therapist_params,
            }
          end.to change(Therapist, :count).by 1
        end
        it "redirect to therapists page" do
          post therapist_registration_path, params: { therapist: therapist_params }
          expect(response).to redirect_to admin_therapists_path
          expect(flash[:notice]).to eq "ユーザーを作成しました。"
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

  describe "#edit" do
    context "login as admin" do
      let!(:admin) { create(:therapist, :admin) }

      it "redirect patients page" do
        sign_in admin
        get edit_therapist_registration_path
        expect(response).to redirect_to patients_path
      end
    end

    context "login as therapist" do
      let!(:therapist) { create(:therapist) }

      it "show edit therapist page" do
        sign_in therapist
        get edit_therapist_registration_path
        expect(response).to render_template :edit
      end
    end

    context "not login" do
      it "redirect login page" do
        get signup_path
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "#update" do
    context "login as admin" do
      let!(:admin) { create(:therapist, :admin) }

      it "redirect to root url" do
        sign_in admin
        patch therapist_registration_path, params: {
          therapist: {
            password: "hogehoge",
            password_confirmation: "hogehoge",
            current_password: "password",
          },
        }
        expect(response).to redirect_to patients_path
      end
    end

    context "login as therapist" do
      let!(:therapist) { create(:therapist) }

      before do
        sign_in therapist
      end

      context "if the parameter is valid" do
        it "is success to update therapist" do
          patch therapist_registration_path, params: {
            therapist: {
              password: "hogehoge",
              password_confirmation: "hogehoge",
              current_password: "password",
            },
          }
          therapist.reload
          expect(therapist.valid_password?("hogehoge")).to be_truthy
        end
        it "redirect to patients page" do
          patch therapist_registration_path, params: {
            therapist: {
              password: "hogehoge",
              password_confirmation: "hogehoge",
              current_password: "password",
            },
          }
          expect(response).to redirect_to patients_path
          expect(flash[:notice]).to eq "パスワードを更新しました。"
        end
      end

      context "if the parameter is invalid" do
        it "is false to update therapits" do
          patch therapist_registration_path, params: {
            therapist: {
              password: "",
              password_confirmation: "",
              current_password: "",
            },
          }
          therapist.reload
          expect(therapist.password).to eq "password"
        end
        it "render signup page" do
          patch therapist_registration_path, params: {
            therapist: {
              password: "",
              password_confirmation: "",
              current_password: "",
            },
          }
          expect(response).to render_template :edit
        end
      end
    end

    context "not login" do
      it "is false to update therapist" do
        patch therapist_registration_path, params: {
          therapist: {
            password: "",
            password_confirmation: "",
            current_password: "",
          },
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
