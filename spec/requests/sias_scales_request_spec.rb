require 'rails_helper'

RSpec.describe "SiasScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:sias_scale) { create(:sias_scale) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#new" do
    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient new sias scale page" do
        get new_patient_sias_scales_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new sias scale page" do
        get new_patient_sias_scales_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new sias scale page" do
        get new_patient_sias_scales_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when show other patient new sias scale page" do
        get new_patient_sias_scales_path  admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path" do
        get new_patient_sias_scales_path admin_patient
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
          post patient_sias_scales_path(admin_patient), params: { sias_scale: sias_scale_params }
        end.to change(SiasScale, :count).by 1
      end

      it "is success to create other patient sias scale" do
        expect do
          post patient_sias_scales_path(therapist_patient), params: { sias_scale: sias_scale_params }
        end.to change(SiasScale, :count).by 1
      end

      it "is correct message" do
        post patient_sias_scales_path(admin_patient), params: { sias_scale: sias_scale_params }
        expect(flash[:success]).to eq "患者番号:#{admin_patient.unique_id}のSIASを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient sias scale" do
        expect do
          post patient_sias_scales_path(therapist_patient), params: { sias_scale: sias_scale_params }
        end.to change(SiasScale, :count).by 1
      end

      it "redirect to root url when create other patient sias scale" do
        post patient_sias_scales_path(admin_patient), params: { sias_scale: sias_scale_params }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path" do
        post patient_sias_scales_path(admin_patient), params: { sias_scale: sias_scale_params }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
