require 'rails_helper'

RSpec.describe "BrsScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_brs) { create(:brs_scale, patient: admin_patient) }
    let!(:therapist_patient_brs) do
      create(:brs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient brs page" do
        get patient_brs_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient brs page" do
        get patient_brs_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient brs page" do
        get patient_brs_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient brs page" do
        get patient_brs_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient brs page" do
        get patient_brs_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_brs) { create(:brs_scale, patient: admin_patient) }
    let!(:therapist_patient_brs) do
      create(:brs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient brs page" do
        get patient_brs_scale_path(
          admin_patient, admin_patient_brs
        )
        expect(response).to render_template :show
      end

      it "show other patient brs page" do
        get patient_brs_scale_path(
          therapist_patient, therapist_patient_brs
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient brs page" do
        get patient_brs_scale_path(
          therapist_patient, therapist_patient_brs
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient brs page" do
        get patient_brs_scale_path(
          admin_patient, admin_patient_brs
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient brs page" do
        get patient_brs_scale_path(
          admin_patient, admin_patient_brs
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#new" do
    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient new brs scale page" do
        get new_patient_brs_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new brs scale page" do
        get new_patient_brs_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new brs scale page" do
        get new_patient_brs_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when show other patient new brs scale page" do
        get new_patient_brs_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get new brs scale page" do
        get new_patient_brs_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:brs_scale_params) { attributes_for(:brs_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient brs scale" do
        expect do
          post patient_brs_scales_path(admin_patient), params: {
            brs_scale: brs_scale_params,
          }
        end.to change(BrsScale, :count).by 1
      end

      it "is success to create other patient brs scale" do
        expect do
          post patient_brs_scales_path(therapist_patient), params: {
            brs_scale: brs_scale_params,
          }
        end.to change(BrsScale, :count).by 1
      end

      it "is redirect to patient page when create brs scale" do
        post patient_brs_scales_path(admin_patient), params: {
          brs_scale: brs_scale_params,
        }
        expect(response).to redirect_to patient_brs_scales_path(admin_patient)
        expect(flash[:success]).to eq "BRSを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient brs scale" do
        expect do
          post patient_brs_scales_path(therapist_patient), params: {
            brs_scale: brs_scale_params,
          }
        end.to change(BrsScale, :count).by 1
      end

      it "is false to create patient brs scale" do
        expect do
          post patient_brs_scales_path(admin_patient), params: {
            brs_scale: brs_scale_params,
          }
        end.not_to change(BrsScale, :count)
      end

      it "redirect to root url when create other patient brs scale" do
        post patient_brs_scales_path(admin_patient), params: { brs_scale: brs_scale_params }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient brs scale" do
        expect do
          post patient_brs_scales_path(admin_patient), params: {
            brs_scale: brs_scale_params,
          }
        end.not_to change(BrsScale, :count)
      end

      it "redirect to login path" do
        post patient_brs_scales_path(admin_patient), params: { brs_scale: brs_scale_params }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_brs) { create(:brs_scale, patient: admin_patient) }
    let!(:therapist_patient_brs) do
      create(:brs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_brs_scale_path(
          admin_patient, admin_patient_brs
        )
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_brs_scale_path(
          therapist_patient, therapist_patient_brs
        )
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_brs_scale_path(
          therapist_patient, therapist_patient_brs
        )
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient brs page" do
        get edit_patient_brs_scale_path(
          admin_patient, admin_patient_brs
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient brs page" do
        get patient_brs_scale_path(
          admin_patient, admin_patient_brs
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_brs) { create(:brs_scale, patient: admin_patient) }
    let!(:therapist_patient_brs) do
      create(:brs_scale, patient: therapist_patient)
    end
    let!(:brs_scale_params) do
      attributes_for(:brs_scale, upper_limb: "stage_one",
                                 finger: "stage_three",
                                 lower_limb: "stage_six")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient brs" do
        patch patient_brs_scale_path(
          admin_patient, admin_patient_brs
        ), params: {
          brs_scale: brs_scale_params,
        }
        admin_patient_brs.reload
        expect(admin_patient_brs.upper_limb).to eq "stage_one"
        expect(admin_patient_brs.finger).to eq "stage_three"
        expect(admin_patient_brs.lower_limb).to eq "stage_six"
      end

      it "is redirect to own patient page" do
        patch patient_brs_scale_path(
          admin_patient, admin_patient_brs
        ), params: {
          brs_scale: brs_scale_params,
        }
        expect(response).to redirect_to patient_brs_scales_path admin_patient
      end

      it "is correct message when success to update own patient brs" do
        patch patient_brs_scale_path(
          admin_patient, admin_patient_brs
        ), params: {
          brs_scale: brs_scale_params,
        }
        expect(flash[:success]).to eq "BRSを編集しました。"
      end

      it "is success to update other patient brs" do
        patch patient_brs_scale_path(
          therapist_patient, therapist_patient_brs
        ), params: {
          brs_scale: brs_scale_params,
        }
        therapist_patient_brs.reload
        expect(therapist_patient_brs.upper_limb).to eq "stage_one"
        expect(therapist_patient_brs.finger).to eq "stage_three"
        expect(therapist_patient_brs.lower_limb).to eq "stage_six"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient brs" do
        patch patient_brs_scale_path(
          therapist_patient, therapist_patient_brs
        ), params: {
          brs_scale: brs_scale_params,
        }
        therapist_patient_brs.reload
        expect(therapist_patient_brs.upper_limb).to eq "stage_one"
        expect(therapist_patient_brs.finger).to eq "stage_three"
        expect(therapist_patient_brs.lower_limb).to eq "stage_six"
      end

      it "is false to update other patient brs" do
        patch patient_brs_scale_path(
          admin_patient, admin_patient_brs
        ), params: {
          brs_scale: brs_scale_params,
        }
        admin_patient_brs.reload
        expect(admin_patient_brs.upper_limb).not_to eq "stage_one"
        expect(admin_patient_brs.finger).not_to eq "stage_three"
        expect(admin_patient_brs.lower_limb).not_to eq "stage_six"
      end

      it "redirect to root url when update other patient brs" do
        patch patient_brs_scale_path(
          admin_patient, admin_patient_brs
        ), params: {
          brs_scale: brs_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient brs" do
        patch patient_brs_scale_path(
          admin_patient, admin_patient_brs
        ), params: {
          brs_scale: brs_scale_params,
        }
        admin_patient_brs.reload
        expect(admin_patient_brs.upper_limb).not_to eq "stage_one"
        expect(admin_patient_brs.finger).not_to eq "stage_three"
        expect(admin_patient_brs.lower_limb).not_to eq "stage_six"
      end

      it "redirect to login path when update other patient brs" do
        patch patient_brs_scale_path(
          admin_patient, admin_patient_brs
        ), params: {
          brs_scale: brs_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_brs) { create(:brs_scale, patient: admin_patient) }
    let!(:therapist_patient_brs) do
      create(:brs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient brs" do
        expect do
          delete patient_brs_scale_path(
            admin_patient, admin_patient_brs
          )
        end.to change(BrsScale, :count).by(-1)
      end

      it "is success to destor other patient brs" do
        expect do
          delete patient_brs_scale_path(
            therapist_patient, therapist_patient_brs
          )
        end.to change(BrsScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient brs" do
        delete patient_brs_scale_path(
          admin_patient, admin_patient_brs
        )
        expect(response).to redirect_to patient_brs_scales_path(admin_patient)
      end

      it "is correct message when destroy patient brs" do
        delete patient_brs_scale_path(
          admin_patient, admin_patient_brs
        )
        expect(flash[:success]).to eq "BRSを削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient brs" do
        expect do
          delete patient_brs_scale_path(
            therapist_patient, therapist_patient_brs
          )
        end.to change(BrsScale, :count).by(-1)
      end

      it "is false to destor other patient brs" do
        expect do
          delete patient_brs_scale_path(
            admin_patient, admin_patient_brs
          )
        end.not_to change(BrsScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient brs" do
        expect do
          delete patient_brs_scale_path(
            admin_patient, admin_patient_brs
          )
        end.not_to change(BrsScale, :count)
      end

      it "redirect to login path when get edit patient brs page" do
        delete patient_brs_scale_path(
          admin_patient, admin_patient_brs
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
