require 'rails_helper'

RSpec.describe "MasScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_mas) { create(:mas_scale, patient: admin_patient) }
    let!(:therapist_patient_mas) do
      create(:mas_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient mas page" do
        get patient_mas_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient mas page" do
        get patient_mas_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient mas page" do
        get patient_mas_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient mas page" do
        get patient_mas_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient mas page" do
        get patient_mas_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_mas) { create(:mas_scale, patient: admin_patient) }
    let!(:therapist_patient_mas) do
      create(:mas_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient mas page" do
        get patient_mas_scale_path(
          admin_patient, admin_patient_mas
        )
        expect(response).to render_template :show
      end

      it "show other patient mas page" do
        get patient_mas_scale_path(
          therapist_patient, therapist_patient_mas
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient mas page" do
        get patient_mas_scale_path(
          therapist_patient, therapist_patient_mas
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient mas page" do
        get patient_mas_scale_path(
          admin_patient, admin_patient_mas
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient mas page" do
        get patient_mas_scale_path(
          admin_patient, admin_patient_mas
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

      it "show own patient new mas scale page" do
        get new_patient_mas_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new mas scale page" do
        get new_patient_mas_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new mas scale page" do
        get new_patient_mas_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when show other patient new mas scale page" do
        get new_patient_mas_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get new mas scale page" do
        get new_patient_mas_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:mas_scale_params) { attributes_for(:mas_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient mas scale" do
        expect do
          post patient_mas_scales_path(admin_patient), params: {
            mas_scale: mas_scale_params,
          }
        end.to change(MasScale, :count).by 1
      end

      it "is success to create other patient mas scale" do
        expect do
          post patient_mas_scales_path(therapist_patient), params: {
            mas_scale: mas_scale_params,
          }
        end.to change(MasScale, :count).by 1
      end

      it "is redirect to patient page when create mas scale" do
        post patient_mas_scales_path(admin_patient), params: {
          mas_scale: mas_scale_params,
        }
        expect(response).to redirect_to patient_mas_scales_path(admin_patient)
        expect(flash[:success]).to eq "MASを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient mas scale" do
        expect do
          post patient_mas_scales_path(therapist_patient), params: {
            mas_scale: mas_scale_params,
          }
        end.to change(MasScale, :count).by 1
      end

      it "is false to create patient mas scale" do
        expect do
          post patient_mas_scales_path(admin_patient), params: {
            mas_scale: mas_scale_params,
          }
        end.not_to change(MasScale, :count)
      end

      it "redirect to root url when create other patient mas scale" do
        post patient_mas_scales_path(admin_patient), params: { mas_scale: mas_scale_params }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient mas scale" do
        expect do
          post patient_mas_scales_path(admin_patient), params: {
            mas_scale: mas_scale_params,
          }
        end.not_to change(MasScale, :count)
      end

      it "redirect to login path" do
        post patient_mas_scales_path(admin_patient), params: { mas_scale: mas_scale_params }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_mas) { create(:mas_scale, patient: admin_patient) }
    let!(:therapist_patient_mas) do
      create(:mas_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_mas_scale_path(
          admin_patient, admin_patient_mas
        )
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_mas_scale_path(
          therapist_patient, therapist_patient_mas
        )
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_mas_scale_path(
          therapist_patient, therapist_patient_mas
        )
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient mas page" do
        get edit_patient_mas_scale_path(
          admin_patient, admin_patient_mas
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient mas page" do
        get patient_mas_scale_path(
          admin_patient, admin_patient_mas
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_mas) { create(:mas_scale, patient: admin_patient) }
    let!(:therapist_patient_mas) do
      create(:mas_scale, patient: therapist_patient)
    end
    let!(:mas_scale_params) do
      attributes_for(:mas_scale, right_elbow_joint: "mild_enhancement",
                                 left_wrist_joint: "rigidity",
                                 right_knee_joint: "significant")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient mas" do
        patch patient_mas_scale_path(
          admin_patient, admin_patient_mas
        ), params: {
          mas_scale: mas_scale_params,
        }
        admin_patient_mas.reload
        expect(admin_patient_mas.right_elbow_joint).to eq "mild_enhancement"
        expect(admin_patient_mas.left_wrist_joint).to eq "rigidity"
        expect(admin_patient_mas.right_knee_joint).to eq "significant"
      end

      it "is redirect to own patient page" do
        patch patient_mas_scale_path(
          admin_patient, admin_patient_mas
        ), params: {
          mas_scale: mas_scale_params,
        }
        expect(response).to redirect_to patient_mas_scales_path admin_patient
      end

      it "is correct message when success to update own patient mas" do
        patch patient_mas_scale_path(
          admin_patient, admin_patient_mas
        ), params: {
          mas_scale: mas_scale_params,
        }
        expect(flash[:success]).to eq "MASを編集しました。"
      end

      it "is success to update other patient mas" do
        patch patient_mas_scale_path(
          therapist_patient, therapist_patient_mas
        ), params: {
          mas_scale: mas_scale_params,
        }
        therapist_patient_mas.reload
        expect(therapist_patient_mas.right_elbow_joint).to eq "mild_enhancement"
        expect(therapist_patient_mas.left_wrist_joint).to eq "rigidity"
        expect(therapist_patient_mas.right_knee_joint).to eq "significant"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient mas" do
        patch patient_mas_scale_path(
          therapist_patient, therapist_patient_mas
        ), params: {
          mas_scale: mas_scale_params,
        }
        therapist_patient_mas.reload
        expect(therapist_patient_mas.right_elbow_joint).to eq "mild_enhancement"
        expect(therapist_patient_mas.left_wrist_joint).to eq "rigidity"
        expect(therapist_patient_mas.right_knee_joint).to eq "significant"
      end

      it "is false to update other patient mas" do
        patch patient_mas_scale_path(
          admin_patient, admin_patient_mas
        ), params: {
          mas_scale: mas_scale_params,
        }
        admin_patient_mas.reload
        expect(admin_patient_mas.right_elbow_joint).not_to eq "mild_enhancement"
        expect(admin_patient_mas.left_wrist_joint).not_to eq "rigidity"
        expect(admin_patient_mas.right_knee_joint).not_to eq "significant"
      end

      it "redirect to root url when update other patient mas" do
        patch patient_mas_scale_path(
          admin_patient, admin_patient_mas
        ), params: {
          mas_scale: mas_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient mas" do
        patch patient_mas_scale_path(
          admin_patient, admin_patient_mas
        ), params: {
          mas_scale: mas_scale_params,
        }
        admin_patient_mas.reload
        expect(therapist_patient_mas.right_elbow_joint).not_to eq "mild_enhancement"
        expect(therapist_patient_mas.left_wrist_joint).not_to eq "rigidity"
        expect(therapist_patient_mas.right_knee_joint).not_to eq "significant"
      end

      it "redirect to login path when update other patient mas" do
        patch patient_mas_scale_path(
          admin_patient, admin_patient_mas
        ), params: {
          mas_scale: mas_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_mas) { create(:mas_scale, patient: admin_patient) }
    let!(:therapist_patient_mas) do
      create(:mas_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient mas" do
        expect do
          delete patient_mas_scale_path(
            admin_patient, admin_patient_mas
          )
        end.to change(MasScale, :count).by(-1)
      end

      it "is success to destor other patient mas" do
        expect do
          delete patient_mas_scale_path(
            therapist_patient, therapist_patient_mas
          )
        end.to change(MasScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient mas" do
        delete patient_mas_scale_path(
          admin_patient, admin_patient_mas
        )
        expect(response).to redirect_to patient_mas_scales_path(admin_patient)
      end

      it "is correct message when destroy patient mas" do
        delete patient_mas_scale_path(
          admin_patient, admin_patient_mas
        )
        expect(flash[:success]).to eq "MASを削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient mas" do
        expect do
          delete patient_mas_scale_path(
            therapist_patient, therapist_patient_mas
          )
        end.to change(MasScale, :count).by(-1)
      end

      it "is false to destor other patient mas" do
        expect do
          delete patient_mas_scale_path(
            admin_patient, admin_patient_mas
          )
        end.not_to change(MasScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient mas" do
        expect do
          delete patient_mas_scale_path(
            admin_patient, admin_patient_mas
          )
        end.not_to change(MasScale, :count)
      end

      it "redirect to login path when get edit patient mas page" do
        delete patient_mas_scale_path(
          admin_patient, admin_patient_mas
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
