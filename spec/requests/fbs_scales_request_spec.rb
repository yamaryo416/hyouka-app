require 'rails_helper'

RSpec.describe "FbsScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_fbs) { create(:fbs_scale, patient: admin_patient) }
    let!(:therapist_patient_fbs) do
      create(:fbs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient fbs page" do
        get patient_fbs_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient fbs page" do
        get patient_fbs_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient fbs page" do
        get patient_fbs_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient fbs page" do
        get patient_fbs_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient fbs page" do
        get patient_fbs_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_fbs) { create(:fbs_scale, patient: admin_patient) }
    let!(:therapist_patient_fbs) do
      create(:fbs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient fbs page" do
        get patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        )
        expect(response).to render_template :show
      end

      it "show other patient fbs page" do
        get patient_fbs_scale_path(
          therapist_patient, therapist_patient_fbs
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient fbs page" do
        get patient_fbs_scale_path(
          therapist_patient, therapist_patient_fbs
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient fbs page" do
        get patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient fbs page" do
        get patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
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

      it "show own patient new fbs scale page" do
        get new_patient_fbs_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new fbs scale page" do
        get new_patient_fbs_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new fbs scale page" do
        get new_patient_fbs_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when show other patient new fbs scale page" do
        get new_patient_fbs_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get new fbs scale page" do
        get new_patient_fbs_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:fbs_scale_params) { attributes_for(:fbs_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient fbs scale" do
        expect do
          post patient_fbs_scales_path(admin_patient), params: {
            fbs_scale: fbs_scale_params,
          }
        end.to change(FbsScale, :count).by 1
      end

      it "is success to create other patient fbs scale" do
        expect do
          post patient_fbs_scales_path(therapist_patient), params: {
            fbs_scale: fbs_scale_params,
          }
        end.to change(FbsScale, :count).by 1
      end

      it "is redirect to patient page when create fbs scale" do
        post patient_fbs_scales_path(admin_patient), params: {
          fbs_scale: fbs_scale_params,
        }
        expect(response).to redirect_to patient_fbs_scales_path(admin_patient)
        expect(flash[:success]).to eq "FBSを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient fbs scale" do
        expect do
          post patient_fbs_scales_path(therapist_patient), params: {
            fbs_scale: fbs_scale_params,
          }
        end.to change(FbsScale, :count).by 1
      end

      it "is false to create patient fbs scale" do
        expect do
          post patient_fbs_scales_path(admin_patient), params: {
            fbs_scale: fbs_scale_params,
          }
        end.not_to change(FbsScale, :count)
      end

      it "redirect to root url when create other patient fbs scale" do
        post patient_fbs_scales_path(admin_patient), params: { fbs_scale: fbs_scale_params }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient fbs scale" do
        expect do
          post patient_fbs_scales_path(admin_patient), params: {
            fbs_scale: fbs_scale_params,
          }
        end.not_to change(FbsScale, :count)
      end

      it "redirect to login path" do
        post patient_fbs_scales_path(admin_patient), params: { fbs_scale: fbs_scale_params }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_fbs) { create(:fbs_scale, patient: admin_patient) }
    let!(:therapist_patient_fbs) do
      create(:fbs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        )
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_fbs_scale_path(
          therapist_patient, therapist_patient_fbs
        )
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_fbs_scale_path(
          therapist_patient, therapist_patient_fbs
        )
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient fbs page" do
        get edit_patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient fbs page" do
        get patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_fbs) { create(:fbs_scale, patient: admin_patient) }
    let!(:therapist_patient_fbs) do
      create(:fbs_scale, patient: therapist_patient)
    end
    let!(:fbs_scale_params) do
      attributes_for(:fbs_scale, stand_up: "zero",
                                 standing: "trace",
                                 sitting: "poor")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient fbs" do
        patch patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        ), params: {
          fbs_scale: fbs_scale_params,
        }
        admin_patient_fbs.reload
        expect(admin_patient_fbs.stand_up).to eq "zero"
        expect(admin_patient_fbs.standing).to eq "trace"
        expect(admin_patient_fbs.sitting).to eq "poor"
      end

      it "is redirect to own patient page" do
        patch patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        ), params: {
          fbs_scale: fbs_scale_params,
        }
        expect(response).to redirect_to patient_fbs_scales_path admin_patient
      end

      it "is correct message when success to update own patient fbs" do
        patch patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        ), params: {
          fbs_scale: fbs_scale_params,
        }
        expect(flash[:success]).to eq "FBSを編集しました。"
      end

      it "is success to update other patient fbs" do
        patch patient_fbs_scale_path(
          therapist_patient, therapist_patient_fbs
        ), params: {
          fbs_scale: fbs_scale_params,
        }
        therapist_patient_fbs.reload
        expect(therapist_patient_fbs.stand_up).to eq "zero"
        expect(therapist_patient_fbs.standing).to eq "trace"
        expect(therapist_patient_fbs.sitting).to eq "poor"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient fbs" do
        patch patient_fbs_scale_path(
          therapist_patient, therapist_patient_fbs
        ), params: {
          fbs_scale: fbs_scale_params,
        }
        therapist_patient_fbs.reload
        expect(therapist_patient_fbs.stand_up).to eq "zero"
        expect(therapist_patient_fbs.standing).to eq "trace"
        expect(therapist_patient_fbs.sitting).to eq "poor"
      end

      it "is false to update other patient fbs" do
        patch patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        ), params: {
          fbs_scale: fbs_scale_params,
        }
        admin_patient_fbs.reload
        expect(admin_patient_fbs.stand_up).not_to eq "zero"
        expect(admin_patient_fbs.standing).not_to eq "trace"
        expect(admin_patient_fbs.sitting).not_to eq "poor"
      end

      it "redirect to root url when update other patient fbs" do
        patch patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        ), params: {
          fbs_scale: fbs_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient fbs" do
        patch patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        ), params: {
          fbs_scale: fbs_scale_params,
        }
        admin_patient_fbs.reload
        expect(therapist_patient_fbs.stand_up).not_to eq "zero"
        expect(therapist_patient_fbs.standing).not_to eq "trace"
        expect(therapist_patient_fbs.sitting).not_to eq "poor"
      end

      it "redirect to login path when update other patient fbs" do
        patch patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        ), params: {
          fbs_scale: fbs_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_fbs) { create(:fbs_scale, patient: admin_patient) }
    let!(:therapist_patient_fbs) do
      create(:fbs_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient fbs" do
        expect do
          delete patient_fbs_scale_path(
            admin_patient, admin_patient_fbs
          )
        end.to change(FbsScale, :count).by(-1)
      end

      it "is success to destor other patient fbs" do
        expect do
          delete patient_fbs_scale_path(
            therapist_patient, therapist_patient_fbs
          )
        end.to change(FbsScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient fbs" do
        delete patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        )
        expect(response).to redirect_to patient_fbs_scales_path(admin_patient)
      end

      it "is correct message when destroy patient fbs" do
        delete patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        )
        expect(flash[:success]).to eq "FBSを削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient fbs" do
        expect do
          delete patient_fbs_scale_path(
            therapist_patient, therapist_patient_fbs
          )
        end.to change(FbsScale, :count).by(-1)
      end

      it "is false to destor other patient fbs" do
        expect do
          delete patient_fbs_scale_path(
            admin_patient, admin_patient_fbs
          )
        end.not_to change(FbsScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient fbs" do
        expect do
          delete patient_fbs_scale_path(
            admin_patient, admin_patient_fbs
          )
        end.not_to change(FbsScale, :count)
      end

      it "redirect to login path when get edit patient fbs page" do
        delete patient_fbs_scale_path(
          admin_patient, admin_patient_fbs
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
