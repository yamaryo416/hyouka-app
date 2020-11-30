require 'rails_helper'

RSpec.describe "BestestScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_bestest) { create(:bestest_scale, patient: admin_patient) }
    let!(:therapist_patient_bestest) do
      create(:bestest_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient bestest page" do
        get patient_bestest_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient bestest page" do
        get patient_bestest_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient bestest page" do
        get patient_bestest_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient bestest page" do
        get patient_bestest_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient bestest page" do
        get patient_bestest_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_bestest) { create(:bestest_scale, patient: admin_patient) }
    let!(:therapist_patient_bestest) do
      create(:bestest_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient bestest page" do
        get patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        expect(response).to render_template :show
      end

      it "show other patient bestest page" do
        get patient_bestest_scale_path(
          therapist_patient, therapist_patient_bestest
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient bestest page" do
        get patient_bestest_scale_path(
          therapist_patient, therapist_patient_bestest
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient bestest page" do
        get patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient bestest page" do
        get patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#new" do
    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient new bestest scale page" do
        get new_patient_bestest_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new bestest scale page" do
        get new_patient_bestest_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new bestest scale page" do
        get new_patient_bestest_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when show other patient new bestest scale page" do
        get new_patient_bestest_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get new bestest scale page" do
        get new_patient_bestest_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:bestest_scale_params) { attributes_for(:bestest_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient bestest scale" do
        expect do
          post patient_bestest_scales_path(admin_patient), params: {
            bestest_scale: bestest_scale_params,
          }
        end.to change(BestestScale, :count).by 1
      end

      it "is success to create other patient bestest scale" do
        expect do
          post patient_bestest_scales_path(therapist_patient), params: {
            bestest_scale: bestest_scale_params,
          }
        end.to change(BestestScale, :count).by 1
      end

      it "is redirect to patient page when create bestest scale" do
        post patient_bestest_scales_path(admin_patient), params: {
          bestest_scale: bestest_scale_params,
        }
        expect(response).to redirect_to patient_bestest_scales_path(admin_patient)
        expect(flash[:success]).to eq "Mini-BESTestを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient bestest scale" do
        expect do
          post patient_bestest_scales_path(therapist_patient), params: {
            bestest_scale: bestest_scale_params,
          }
        end.to change(BestestScale, :count).by 1
      end

      it "is false to create patient bestest scale" do
        expect do
          post patient_bestest_scales_path(admin_patient), params: {
            bestest_scale: bestest_scale_params,
          }
        end.not_to change(BestestScale, :count)
      end

      it "redirect to root url when create other patient bestest scale" do
        post patient_bestest_scales_path(admin_patient), params: {
          bestest_scale: bestest_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient bestest scale" do
        expect do
          post patient_bestest_scales_path(admin_patient), params: {
            bestest_scale: bestest_scale_params,
          }
        end.not_to change(BestestScale, :count)
      end

      it "redirect to login path" do
        post patient_bestest_scales_path(admin_patient), params: {
          bestest_scale: bestest_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_bestest) { create(:bestest_scale, patient: admin_patient) }
    let!(:therapist_patient_bestest) do
      create(:bestest_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_bestest_scale_path(therapist_patient, therapist_patient_bestest)
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_bestest_scale_path(therapist_patient, therapist_patient_bestest)
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient bestest page" do
        get edit_patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient bestest page" do
        get edit_patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_bestest) { create(:bestest_scale, patient: admin_patient) }
    let!(:therapist_patient_bestest) do
      create(:bestest_scale, patient: therapist_patient)
    end
    let!(:bestest_scale_params) do
      attributes_for(:bestest_scale, from_sitting_to_standing: "zero",
                                     standing_on_tiptoes: "one",
                                     standing_on_one_leg: "two")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient bestest" do
        patch patient_bestest_scale_path(admin_patient, admin_patient_bestest), params: {
          bestest_scale: bestest_scale_params,
        }
        admin_patient_bestest.reload
        expect(admin_patient_bestest.from_sitting_to_standing).to eq "zero"
        expect(admin_patient_bestest.standing_on_tiptoes).to eq "one"
        expect(admin_patient_bestest.standing_on_one_leg).to eq "two"
      end

      it "is redirect to own patient bestest page" do
        patch patient_bestest_scale_path(admin_patient, admin_patient_bestest), params: {
          bestest_scale: bestest_scale_params,
        }
        expect(response).to redirect_to patient_bestest_scales_path admin_patient
      end

      it "is correct message when success to update own patient bestest" do
        patch patient_bestest_scale_path(admin_patient, admin_patient_bestest), params: {
          bestest_scale: bestest_scale_params,
        }
        expect(flash[:success]).to eq "Mini-BESTestを編集しました。"
      end

      it "is success to update other patient bestest" do
        patch patient_bestest_scale_path(therapist_patient, therapist_patient_bestest), params: {
          bestest_scale: bestest_scale_params,
        }
        therapist_patient_bestest.reload
        expect(therapist_patient_bestest.from_sitting_to_standing).to eq "zero"
        expect(therapist_patient_bestest.standing_on_tiptoes).to eq "one"
        expect(therapist_patient_bestest.standing_on_one_leg).to eq "two"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient bestest" do
        patch patient_bestest_scale_path(therapist_patient, therapist_patient_bestest), params: {
          bestest_scale: bestest_scale_params,
        }
        therapist_patient_bestest.reload
        expect(therapist_patient_bestest.from_sitting_to_standing).to eq "zero"
        expect(therapist_patient_bestest.standing_on_tiptoes).to eq "one"
        expect(therapist_patient_bestest.standing_on_one_leg).to eq "two"
      end

      it "is false to update other patient bestest" do
        patch patient_bestest_scale_path(admin_patient, admin_patient_bestest), params: {
          bestest_scale: bestest_scale_params,
        }
        admin_patient_bestest.reload
        expect(admin_patient_bestest.from_sitting_to_standing).not_to eq "zero"
        expect(admin_patient_bestest.standing_on_tiptoes).not_to eq "one"
        expect(admin_patient_bestest.standing_on_one_leg).not_to eq "two"
      end

      it "redirect to root url when update other patient bestest" do
        patch patient_bestest_scale_path(admin_patient, admin_patient_bestest), params: {
          bestest_scale: bestest_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient bestest" do
        patch patient_bestest_scale_path(admin_patient, admin_patient_bestest), params: {
          bestest_scale: bestest_scale_params,
        }
        admin_patient_bestest.reload
        expect(therapist_patient_bestest.from_sitting_to_standing).not_to eq "zero"
        expect(therapist_patient_bestest.standing_on_tiptoes).not_to eq "one"
        expect(therapist_patient_bestest.standing_on_one_leg).not_to eq "two"
      end

      it "redirect to login path when update other patient bestest" do
        patch patient_bestest_scale_path(admin_patient, admin_patient_bestest), params: {
          bestest_scale: bestest_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_bestest) { create(:bestest_scale, patient: admin_patient) }
    let!(:therapist_patient_bestest) do
      create(:bestest_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient bestest" do
        expect do
          delete patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        end.to change(BestestScale, :count).by(-1)
      end

      it "is success to destor other patient bestest" do
        expect do
          delete patient_bestest_scale_path(therapist_patient, therapist_patient_bestest)
        end.to change(BestestScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient bestest" do
        delete patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        expect(response).to redirect_to patient_bestest_scales_path(admin_patient)
      end

      it "is correct message when destroy patient bestest" do
        delete patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        expect(flash[:success]).to eq "Mini-BESTestを削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient bestest" do
        expect do
          delete patient_bestest_scale_path(therapist_patient, therapist_patient_bestest)
        end.to change(BestestScale, :count).by(-1)
      end

      it "is false to destor other patient bestest" do
        expect do
          delete patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        end.not_to change(BestestScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient bestest" do
        expect do
          delete patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        end.not_to change(BestestScale, :count)
      end

      it "redirect to login path when get edit patient bestest page" do
        delete patient_bestest_scale_path(admin_patient, admin_patient_bestest)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
