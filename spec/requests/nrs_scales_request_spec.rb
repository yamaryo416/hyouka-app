require 'rails_helper'

RSpec.describe "NrsScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_nrs) { create(:nrs_scale, patient: admin_patient) }
    let!(:therapist_patient_nrs) do
      create(:nrs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient nrs page" do
        get patient_nrs_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient nrs page" do
        get patient_nrs_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient nrs page" do
        get patient_nrs_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient nrs page" do
        get patient_nrs_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient nrs page" do
        get patient_nrs_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#new" do
    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient new nrs scale page" do
        get new_patient_nrs_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new nrs scale page" do
        get new_patient_nrs_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new nrs scale page" do
        get new_patient_nrs_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when show other patient new nrs scale page" do
        get new_patient_nrs_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get new nrs scale page" do
        get new_patient_nrs_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:nrs_scale_params) { attributes_for(:nrs_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient nrs scale" do
        expect do
          post patient_nrs_scales_path(admin_patient), params: {
            nrs_scale: nrs_scale_params,
          }
        end.to change(NrsScale, :count).by 1
      end

      it "is success to create other patient nrs scale" do
        expect do
          post patient_nrs_scales_path(therapist_patient), params: {
            nrs_scale: nrs_scale_params,
          }
        end.to change(NrsScale, :count).by 1
      end

      it "is redirect to patient page when create nrs scale" do
        post patient_nrs_scales_path(admin_patient), params: {
          nrs_scale: nrs_scale_params,
        }
        expect(response).to redirect_to patient_nrs_scales_path(admin_patient)
        expect(flash[:success]).to eq "NRSを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient nrs scale" do
        expect do
          post patient_nrs_scales_path(therapist_patient), params: {
            nrs_scale: nrs_scale_params,
          }
        end.to change(NrsScale, :count).by 1
      end

      it "is false to create patient nrs scale" do
        expect do
          post patient_nrs_scales_path(admin_patient), params: {
            nrs_scale: nrs_scale_params,
          }
        end.not_to change(NrsScale, :count)
      end

      it "redirect to root url when create other patient nrs scale" do
        post patient_nrs_scales_path(admin_patient), params: {
          nrs_scale: nrs_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient nrs scale" do
        expect do
          post patient_nrs_scales_path(admin_patient), params: {
            nrs_scale: nrs_scale_params,
          }
        end.not_to change(NrsScale, :count)
      end

      it "redirect to login path" do
        post patient_nrs_scales_path(admin_patient), params: {
          nrs_scale: nrs_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_nrs) { create(:nrs_scale, patient: admin_patient) }
    let!(:therapist_patient_nrs) do
      create(:nrs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_nrs_scale_path(admin_patient, admin_patient_nrs)
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_nrs_scale_path(therapist_patient, therapist_patient_nrs)
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_nrs_scale_path(therapist_patient, therapist_patient_nrs)
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient nrs page" do
        get edit_patient_nrs_scale_path(admin_patient, admin_patient_nrs)
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient nrs page" do
        get edit_patient_nrs_scale_path(admin_patient, admin_patient_nrs)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_nrs) { create(:nrs_scale, patient: admin_patient) }
    let!(:therapist_patient_nrs) do
      create(:nrs_scale, patient: therapist_patient)
    end
    let!(:nrs_scale_params) do
      attributes_for(:nrs_scale, rating: 3,
                                 status: "resting",
                                 supplement: "伸長時痛")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient nrs" do
        patch patient_nrs_scale_path(admin_patient, admin_patient_nrs), params: {
          nrs_scale: nrs_scale_params,
        }
        admin_patient_nrs.reload
        expect(admin_patient_nrs.rating).to eq 3
        expect(admin_patient_nrs.status).to eq "resting"
        expect(admin_patient_nrs.supplement).to eq "伸長時痛"
      end

      it "is redirect to own patient nrs page" do
        patch patient_nrs_scale_path(admin_patient, admin_patient_nrs), params: {
          nrs_scale: nrs_scale_params,
        }
        expect(response).to redirect_to patient_nrs_scales_path admin_patient
      end

      it "is correct message when success to update own patient nrs" do
        patch patient_nrs_scale_path(admin_patient, admin_patient_nrs), params: {
          nrs_scale: nrs_scale_params,
        }
        expect(flash[:success]).to eq "NRSを編集しました。"
      end

      it "is success to update other patient nrs" do
        patch patient_nrs_scale_path(therapist_patient, therapist_patient_nrs), params: {
          nrs_scale: nrs_scale_params,
        }
        therapist_patient_nrs.reload
        expect(therapist_patient_nrs.rating).to eq 3
        expect(therapist_patient_nrs.status).to eq "resting"
        expect(therapist_patient_nrs.supplement).to eq "伸長時痛"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient nrs" do
        patch patient_nrs_scale_path(therapist_patient, therapist_patient_nrs), params: {
          nrs_scale: nrs_scale_params,
        }
        therapist_patient_nrs.reload
        expect(therapist_patient_nrs.rating).to eq 3
        expect(therapist_patient_nrs.status).to eq "resting"
        expect(therapist_patient_nrs.supplement).to eq "伸長時痛"
      end

      it "is false to update other patient nrs" do
        patch patient_nrs_scale_path(admin_patient, admin_patient_nrs), params: {
          nrs_scale: nrs_scale_params,
        }
        admin_patient_nrs.reload
        expect(admin_patient_nrs.rating).not_to eq 3
        expect(admin_patient_nrs.status).not_to eq "resting"
        expect(admin_patient_nrs.supplement).not_to eq "伸長時痛"
      end

      it "redirect to root url when update other patient nrs" do
        patch patient_nrs_scale_path(admin_patient, admin_patient_nrs), params: {
          nrs_scale: nrs_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient nrs" do
        patch patient_nrs_scale_path(admin_patient, admin_patient_nrs), params: {
          nrs_scale: nrs_scale_params,
        }
        admin_patient_nrs.reload
        expect(therapist_patient_nrs.rating).not_to eq 3
        expect(therapist_patient_nrs.status).not_to eq "resting"
        expect(therapist_patient_nrs.supplement).not_to eq "伸長時痛"
      end

      it "redirect to login path when update other patient nrs" do
        patch patient_nrs_scale_path(admin_patient, admin_patient_nrs), params: {
          nrs_scale: nrs_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_nrs) { create(:nrs_scale, patient: admin_patient) }
    let!(:therapist_patient_nrs) do
      create(:nrs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient nrs" do
        expect do
          delete patient_nrs_scale_path(admin_patient, admin_patient_nrs)
        end.to change(NrsScale, :count).by(-1)
      end

      it "is success to destor other patient nrs" do
        expect do
          delete patient_nrs_scale_path(therapist_patient, therapist_patient_nrs)
        end.to change(NrsScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient nrs" do
        delete patient_nrs_scale_path(admin_patient, admin_patient_nrs)
        expect(response).to redirect_to patient_nrs_scales_path(admin_patient)
      end

      it "is correct message when destroy patient nrs" do
        delete patient_nrs_scale_path(admin_patient, admin_patient_nrs)
        expect(flash[:success]).to eq "NRSを削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient nrs" do
        expect do
          delete patient_nrs_scale_path(therapist_patient, therapist_patient_nrs)
        end.to change(NrsScale, :count).by(-1)
      end

      it "is false to destor other patient nrs" do
        expect do
          delete patient_nrs_scale_path(admin_patient, admin_patient_nrs)
        end.not_to change(NrsScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient nrs" do
        expect do
          delete patient_nrs_scale_path(admin_patient, admin_patient_nrs)
        end.not_to change(NrsScale, :count)
      end

      it "redirect to login path when get edit patient nrs page" do
        delete patient_nrs_scale_path(admin_patient, admin_patient_nrs)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
