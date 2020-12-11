require 'rails_helper'

RSpec.describe "MmtScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_mmt) { create(:mmt_scale, patient: admin_patient) }
    let!(:therapist_patient_mmt) do
      create(:mmt_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient mmt page" do
        get patient_mmt_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient mmt page" do
        get patient_mmt_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient mmt page" do
        get patient_mmt_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient mmt page" do
        get patient_mmt_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient mmt page" do
        get patient_mmt_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_mmt) { create(:mmt_scale, patient: admin_patient) }
    let!(:therapist_patient_mmt) do
      create(:mmt_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient mmt page" do
        get patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        )
        expect(response).to render_template :show
      end

      it "show other patient mmt page" do
        get patient_mmt_scale_path(
          therapist_patient, therapist_patient_mmt
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient mmt page" do
        get patient_mmt_scale_path(
          therapist_patient, therapist_patient_mmt
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient mmt page" do
        get patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient mmt page" do
        get patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
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

      it "show own patient new mmt scale page" do
        get new_patient_mmt_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new mmt scale page" do
        get new_patient_mmt_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new mmt scale page" do
        get new_patient_mmt_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when get other patient new mmt scale page" do
        get new_patient_mmt_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path" do
        get new_patient_mmt_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:mmt_scale_params) { attributes_for(:mmt_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient mmt scale" do
        expect do
          post patient_mmt_scales_path(admin_patient), params: {
            mmt_scale: mmt_scale_params,
          }
        end.to change(MmtScale, :count).by 1
      end

      it "is success to create other patient mmt scale" do
        expect do
          post patient_mmt_scales_path(therapist_patient), params: {
            mmt_scale: mmt_scale_params,
          }
        end.to change(MmtScale, :count).by 1
      end

      it "is redirect to patient page when create mmt scale" do
        post patient_mmt_scales_path(admin_patient), params: {
          mmt_scale: mmt_scale_params,
        }
        expect(response).to redirect_to patient_mmt_scales_path(admin_patient)
        expect(flash[:success]).to eq "MMTを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient mmt scale" do
        expect do
          post patient_mmt_scales_path(therapist_patient), params: {
            mmt_scale: mmt_scale_params,
          }
        end.to change(MmtScale, :count).by 1
      end

      it "is false to create patient mmt scale" do
        expect do
          post patient_mmt_scales_path(admin_patient), params: {
            mmt_scale: mmt_scale_params,
          }
        end.not_to change(MmtScale, :count)
      end

      it "redirect to root url when create other patient mmt scale" do
        post patient_mmt_scales_path(admin_patient), params: { mmt_scale: mmt_scale_params }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient mmt scale" do
        expect do
          post patient_mmt_scales_path(admin_patient), params: {
            mmt_scale: mmt_scale_params,
          }
        end.not_to change(MmtScale, :count)
      end

      it "redirect to login path" do
        post patient_mmt_scales_path(admin_patient), params: { mmt_scale: mmt_scale_params }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_mmt) { create(:mmt_scale, patient: admin_patient) }
    let!(:therapist_patient_mmt) do
      create(:mmt_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        )
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_mmt_scale_path(
          therapist_patient, therapist_patient_mmt
        )
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_mmt_scale_path(
          therapist_patient, therapist_patient_mmt
        )
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient mmt page" do
        get edit_patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient mmt page" do
        get patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_mmt) { create(:mmt_scale, patient: admin_patient) }
    let!(:therapist_patient_mmt) do
      create(:mmt_scale, patient: therapist_patient)
    end
    let!(:mmt_scale_params) do
      attributes_for(:mmt_scale, right_shoulder_flexion: "good",
                                 right_hip_adduction: "fair",
                                 left_ankle_extension: "trace_poor")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient mmt" do
        patch patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        ), params: {
          mmt_scale: mmt_scale_params,
        }
        admin_patient_mmt.reload
        expect(admin_patient_mmt.right_shoulder_flexion).to eq "good"
        expect(admin_patient_mmt.right_hip_adduction).to eq "fair"
        expect(admin_patient_mmt.left_ankle_extension).to eq "trace_poor"
      end

      it "is redirect to own patient page" do
        patch patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        ), params: {
          mmt_scale: mmt_scale_params,
        }
        expect(response).to redirect_to patient_mmt_scales_path admin_patient
      end

      it "is correct message when success to update own patient mmt" do
        patch patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        ), params: {
          mmt_scale: mmt_scale_params,
        }
        expect(flash[:success]).to eq "MMTを編集しました。"
      end

      it "is success to update other patient mmt" do
        patch patient_mmt_scale_path(
          therapist_patient, therapist_patient_mmt
        ), params: {
          mmt_scale: mmt_scale_params,
        }
        therapist_patient_mmt.reload
        expect(therapist_patient_mmt.right_shoulder_flexion).to eq "good"
        expect(therapist_patient_mmt.right_hip_adduction).to eq "fair"
        expect(therapist_patient_mmt.left_ankle_extension).to eq "trace_poor"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient mmt" do
        patch patient_mmt_scale_path(
          therapist_patient, therapist_patient_mmt
        ), params: {
          mmt_scale: mmt_scale_params,
        }
        therapist_patient_mmt.reload
        expect(therapist_patient_mmt.right_shoulder_flexion).to eq "good"
        expect(therapist_patient_mmt.right_hip_adduction).to eq "fair"
        expect(therapist_patient_mmt.left_ankle_extension).to eq "trace_poor"
      end

      it "is false to update other patient mmt" do
        patch patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        ), params: {
          mmt_scale: mmt_scale_params,
        }
        admin_patient_mmt.reload
        expect(therapist_patient_mmt.right_shoulder_flexion).not_to eq "good"
        expect(therapist_patient_mmt.right_hip_adduction).not_to eq "fair"
        expect(therapist_patient_mmt.left_ankle_extension).not_to eq "trace_poor"
      end

      it "redirect to root url when update other patient mmt" do
        patch patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        ), params: {
          mmt_scale: mmt_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient mmt" do
        patch patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        ), params: {
          mmt_scale: mmt_scale_params,
        }
        admin_patient_mmt.reload
        expect(therapist_patient_mmt.right_shoulder_flexion).not_to eq "good"
        expect(therapist_patient_mmt.right_hip_adduction).not_to eq "fair"
        expect(therapist_patient_mmt.left_ankle_extension).not_to eq "trace_poor"
      end

      it "redirect to login path when update other patient mmt" do
        patch patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        ), params: {
          mmt_scale: mmt_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_mmt) { create(:mmt_scale, patient: admin_patient) }
    let!(:therapist_patient_mmt) do
      create(:mmt_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient mmt" do
        expect do
          delete patient_mmt_scale_path(
            admin_patient, admin_patient_mmt
          )
        end.to change(MmtScale, :count).by(-1)
      end

      it "is success to destor other patient mmt" do
        expect do
          delete patient_mmt_scale_path(
            therapist_patient, therapist_patient_mmt
          )
        end.to change(MmtScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient mmt" do
        delete patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        )
        expect(response).to redirect_to patient_mmt_scales_path(admin_patient)
      end

      it "is correct message when destroy patient mmt" do
        delete patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        )
        expect(flash[:success]).to eq "MMTを削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient mmt" do
        expect do
          delete patient_mmt_scale_path(
            therapist_patient, therapist_patient_mmt
          )
        end.to change(MmtScale, :count).by(-1)
      end

      it "is false to destor other patient mmt" do
        expect do
          delete patient_mmt_scale_path(
            admin_patient, admin_patient_mmt
          )
        end.not_to change(MmtScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient mmt" do
        expect do
          delete patient_mmt_scale_path(
            admin_patient, admin_patient_mmt
          )
        end.not_to change(MmtScale, :count)
      end

      it "redirect to login path when get edit patient mmt page" do
        delete patient_mmt_scale_path(
          admin_patient, admin_patient_mmt
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
