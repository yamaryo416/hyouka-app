require 'rails_helper'

RSpec.describe "SiasScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_sias) { create(:sias_scale, patient: admin_patient) }
    let!(:therapist_patient_sias) do
      create(:sias_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient sias page" do
        get patient_sias_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient sias page" do
        get patient_sias_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient sias page" do
        get patient_sias_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient sias page" do
        get patient_sias_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient sias page" do
        get patient_sias_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_sias) { create(:sias_scale, patient: admin_patient) }
    let!(:therapist_patient_sias) do
      create(:sias_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient sias page" do
        get patient_sias_scale_path(
          admin_patient, admin_patient_sias
        )
        expect(response).to render_template :show
      end

      it "show other patient sias page" do
        get patient_sias_scale_path(
          therapist_patient, therapist_patient_sias
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient sias page" do
        get patient_sias_scale_path(
          therapist_patient, therapist_patient_sias
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient sias page" do
        get patient_sias_scale_path(
          admin_patient, admin_patient_sias
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient sias page" do
        get patient_sias_scale_path(
          admin_patient, admin_patient_sias
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

      it "show own patient new sias scale page" do
        get new_patient_sias_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new sias scale page" do
        get new_patient_sias_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new sias scale page" do
        get new_patient_sias_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when show other patient new sias scale page" do
        get new_patient_sias_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get new sias scale page" do
        get new_patient_sias_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:sias_scale_params) { attributes_for(:sias_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient sias scale" do
        expect do
          post patient_sias_scales_path(admin_patient), params: {
            sias_scale: sias_scale_params,
          }
        end.to change(SiasScale, :count).by 1
      end

      it "is success to create other patient sias scale" do
        expect do
          post patient_sias_scales_path(therapist_patient), params: {
            sias_scale: sias_scale_params,
          }
        end.to change(SiasScale, :count).by 1
      end

      it "is redirect to patient page when create sias scale" do
        post patient_sias_scales_path(admin_patient), params: {
          sias_scale: sias_scale_params,
        }
        expect(response).to redirect_to patient_sias_scales_path(admin_patient)
        expect(flash[:success]).to eq "SIASを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient sias scale" do
        expect do
          post patient_sias_scales_path(therapist_patient), params: {
            sias_scale: sias_scale_params,
          }
        end.to change(SiasScale, :count).by 1
      end

      it "is false to create patient sias scale" do
        expect do
          post patient_sias_scales_path(admin_patient), params: {
            sias_scale: sias_scale_params,
          }
        end.not_to change(SiasScale, :count)
      end

      it "redirect to root url when create other patient sias scale" do
        post patient_sias_scales_path(admin_patient), params: { sias_scale: sias_scale_params }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient sias scale" do
        expect do
          post patient_sias_scales_path(admin_patient), params: {
            sias_scale: sias_scale_params,
          }
        end.not_to change(SiasScale, :count)
      end

      it "redirect to login path" do
        post patient_sias_scales_path(admin_patient), params: { sias_scale: sias_scale_params }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_sias) { create(:sias_scale, patient: admin_patient) }
    let!(:therapist_patient_sias) do
      create(:sias_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_sias_scale_path(
          admin_patient, admin_patient_sias
        )
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_sias_scale_path(
          therapist_patient, therapist_patient_sias
        )
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_sias_scale_path(
          therapist_patient, therapist_patient_sias
        )
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient sias page" do
        get edit_patient_sias_scale_path(
          admin_patient, admin_patient_sias
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient sias page" do
        get patient_sias_scale_path(
          admin_patient, admin_patient_sias
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_sias) { create(:sias_scale, patient: admin_patient) }
    let!(:therapist_patient_sias) do
      create(:sias_scale, patient: therapist_patient)
    end
    let!(:sias_scale_params) do
      attributes_for(:sias_scale, shoulder_motor_function: "awkward",
                                  finger_motor_function: "move_a_little",
                                  hip_motor_function: "normal")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient sias" do
        patch patient_sias_scale_path(
          admin_patient, admin_patient_sias
        ), params: {
          sias_scale: sias_scale_params,
        }
        admin_patient_sias.reload
        expect(admin_patient_sias.shoulder_motor_function).to eq "awkward"
        expect(admin_patient_sias.finger_motor_function).to eq "move_a_little"
        expect(admin_patient_sias.hip_motor_function).to eq "normal"
      end

      it "is redirect to own patient page" do
        patch patient_sias_scale_path(
          admin_patient, admin_patient_sias
        ), params: {
          sias_scale: sias_scale_params,
        }
        expect(response).to redirect_to patient_sias_scales_path admin_patient
      end

      it "is correct message when success to update own patient sias" do
        patch patient_sias_scale_path(
          admin_patient, admin_patient_sias
        ), params: {
          sias_scale: sias_scale_params,
        }
        expect(flash[:success]).to eq "SIASを編集しました。"
      end

      it "is success to update other patient sias" do
        patch patient_sias_scale_path(
          therapist_patient, therapist_patient_sias
        ), params: {
          sias_scale: sias_scale_params,
        }
        therapist_patient_sias.reload
        expect(therapist_patient_sias.shoulder_motor_function).to eq "awkward"
        expect(therapist_patient_sias.finger_motor_function).to eq "move_a_little"
        expect(therapist_patient_sias.hip_motor_function).to eq "normal"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient sias" do
        patch patient_sias_scale_path(
          therapist_patient, therapist_patient_sias
        ), params: {
          sias_scale: sias_scale_params,
        }
        therapist_patient_sias.reload
        expect(therapist_patient_sias.shoulder_motor_function).to eq "awkward"
        expect(therapist_patient_sias.finger_motor_function).to eq "move_a_little"
        expect(therapist_patient_sias.hip_motor_function).to eq "normal"
      end

      it "is false to update other patient sias" do
        patch patient_sias_scale_path(
          admin_patient, admin_patient_sias
        ), params: {
          sias_scale: sias_scale_params,
        }
        admin_patient_sias.reload
        expect(admin_patient_sias.shoulder_motor_function).not_to eq "awkward"
        expect(admin_patient_sias.finger_motor_function).not_to eq "move_a_little"
        expect(admin_patient_sias.hip_motor_function).not_to eq "normal"
      end

      it "redirect to root url when update other patient sias" do
        patch patient_sias_scale_path(
          admin_patient, admin_patient_sias
        ), params: {
          sias_scale: sias_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient sias" do
        patch patient_sias_scale_path(
          admin_patient, admin_patient_sias
        ), params: {
          sias_scale: sias_scale_params,
        }
        admin_patient_sias.reload
        expect(therapist_patient_sias.shoulder_motor_function).not_to eq "awkward"
        expect(therapist_patient_sias.finger_motor_function).not_to eq "move_a_little"
        expect(therapist_patient_sias.hip_motor_function).not_to eq "normal"
      end

      it "redirect to login path when update other patient sias" do
        patch patient_sias_scale_path(
          admin_patient, admin_patient_sias
        ), params: {
          sias_scale: sias_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_sias) { create(:sias_scale, patient: admin_patient) }
    let!(:therapist_patient_sias) do
      create(:sias_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient sias" do
        expect do
          delete patient_sias_scale_path(
            admin_patient, admin_patient_sias
          )
        end.to change(SiasScale, :count).by(-1)
      end

      it "is success to destor other patient sias" do
        expect do
          delete patient_sias_scale_path(
            therapist_patient, therapist_patient_sias
          )
        end.to change(SiasScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient sias" do
        delete patient_sias_scale_path(
          admin_patient, admin_patient_sias
        )
        expect(response).to redirect_to patient_sias_scales_path(admin_patient)
      end

      it "is correct message when destroy patient sias" do
        delete patient_sias_scale_path(
          admin_patient, admin_patient_sias
        )
        expect(flash[:success]).to eq "SIASを削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient sias" do
        expect do
          delete patient_sias_scale_path(
            therapist_patient, therapist_patient_sias
          )
        end.to change(SiasScale, :count).by(-1)
      end

      it "is false to destor other patient sias" do
        expect do
          delete patient_sias_scale_path(
            admin_patient, admin_patient_sias
          )
        end.not_to change(SiasScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient sias" do
        expect do
          delete patient_sias_scale_path(
            admin_patient, admin_patient_sias
          )
        end.not_to change(SiasScale, :count)
      end

      it "redirect to login path when get edit patient sias page" do
        delete patient_sias_scale_path(
          admin_patient, admin_patient_sias
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
