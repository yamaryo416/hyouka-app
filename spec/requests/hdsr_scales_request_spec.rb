require 'rails_helper'

RSpec.describe "HdsrScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_hdsr) { create(:hdsr_scale, patient: admin_patient) }
    let!(:therapist_patient_hdsr) do
      create(:hdsr_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient hdsr page" do
        get patient_hdsr_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient hdsr page" do
        get patient_hdsr_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient hdsr page" do
        get patient_hdsr_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient hdsr page" do
        get patient_hdsr_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient hdsr page" do
        get patient_hdsr_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#new" do
    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient new hdsr scale page" do
        get new_patient_hdsr_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new hdsr scale page" do
        get new_patient_hdsr_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new hdsr scale page" do
        get new_patient_hdsr_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when show other patient new hdsr scale page" do
        get new_patient_hdsr_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get new hdsr scale page" do
        get new_patient_hdsr_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:hdsr_scale_params) { attributes_for(:hdsr_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient hdsr scale" do
        expect do
          post patient_hdsr_scales_path(admin_patient), params: {
            hdsr_scale: hdsr_scale_params,
          }
        end.to change(HdsrScale, :count).by 1
      end

      it "is success to create other patient hdsr scale" do
        expect do
          post patient_hdsr_scales_path(therapist_patient), params: {
            hdsr_scale: hdsr_scale_params,
          }
        end.to change(HdsrScale, :count).by 1
      end

      it "is redirect to patient page when create hdsr scale" do
        post patient_hdsr_scales_path(admin_patient), params: {
          hdsr_scale: hdsr_scale_params,
        }
        expect(response).to redirect_to patient_hdsr_scales_path(admin_patient)
        expect(flash[:success]).to eq "HDS-Rを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient hdsr scale" do
        expect do
          post patient_hdsr_scales_path(therapist_patient), params: {
            hdsr_scale: hdsr_scale_params,
          }
        end.to change(HdsrScale, :count).by 1
      end

      it "is false to create patient hdsr scale" do
        expect do
          post patient_hdsr_scales_path(admin_patient), params: {
            hdsr_scale: hdsr_scale_params,
          }
        end.not_to change(HdsrScale, :count)
      end

      it "redirect to root url when create other patient hdsr scale" do
        post patient_hdsr_scales_path(admin_patient), params: {
          hdsr_scale: hdsr_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient hdsr scale" do
        expect do
          post patient_hdsr_scales_path(admin_patient), params: {
            hdsr_scale: hdsr_scale_params,
          }
        end.not_to change(HdsrScale, :count)
      end

      it "redirect to login path" do
        post patient_hdsr_scales_path(admin_patient), params: {
          hdsr_scale: hdsr_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_hdsr) { create(:hdsr_scale, patient: admin_patient) }
    let!(:therapist_patient_hdsr) do
      create(:hdsr_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_hdsr_scale_path(admin_patient, admin_patient_hdsr)
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_hdsr_scale_path(therapist_patient, therapist_patient_hdsr)
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_hdsr_scale_path(therapist_patient, therapist_patient_hdsr)
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient hdsr page" do
        get edit_patient_hdsr_scale_path(admin_patient, admin_patient_hdsr)
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient hdsr page" do
        get edit_patient_hdsr_scale_path(admin_patient, admin_patient_hdsr)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_hdsr) { create(:hdsr_scale, patient: admin_patient) }
    let!(:therapist_patient_hdsr) do
      create(:hdsr_scale, patient: therapist_patient)
    end
    let!(:hdsr_scale_params) do
      attributes_for(:hdsr_scale, age: 1,
                                  year: 1,
                                  month: 1)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient hdsr" do
        patch patient_hdsr_scale_path(admin_patient, admin_patient_hdsr), params: {
          hdsr_scale: hdsr_scale_params,
        }
        admin_patient_hdsr.reload
        expect(admin_patient_hdsr.age).to eq 1
        expect(admin_patient_hdsr.year).to eq 1
        expect(admin_patient_hdsr.month).to eq 1
      end

      it "is redirect to own patient hdsr page" do
        patch patient_hdsr_scale_path(admin_patient, admin_patient_hdsr), params: {
          hdsr_scale: hdsr_scale_params,
        }
        expect(response).to redirect_to patient_hdsr_scales_path admin_patient
      end

      it "is correct message when success to update own patient hdsr" do
        patch patient_hdsr_scale_path(admin_patient, admin_patient_hdsr), params: {
          hdsr_scale: hdsr_scale_params,
        }
        expect(flash[:success]).to eq "HDS-Rを編集しました。"
      end

      it "is success to update other patient hdsr" do
        patch patient_hdsr_scale_path(therapist_patient, therapist_patient_hdsr), params: {
          hdsr_scale: hdsr_scale_params,
        }
        therapist_patient_hdsr.reload
        expect(therapist_patient_hdsr.age).to eq 1
        expect(therapist_patient_hdsr.year).to eq 1
        expect(therapist_patient_hdsr.month).to eq 1
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient hdsr" do
        patch patient_hdsr_scale_path(therapist_patient, therapist_patient_hdsr), params: {
          hdsr_scale: hdsr_scale_params,
        }
        therapist_patient_hdsr.reload
        expect(therapist_patient_hdsr.age).to eq 1
        expect(therapist_patient_hdsr.year).to eq 1
        expect(therapist_patient_hdsr.month).to eq 1
      end

      it "is false to update other patient hdsr" do
        patch patient_hdsr_scale_path(admin_patient, admin_patient_hdsr), params: {
          hdsr_scale: hdsr_scale_params,
        }
        admin_patient_hdsr.reload
        expect(admin_patient_hdsr.age).not_to eq 1
        expect(admin_patient_hdsr.year).not_to eq 1
        expect(admin_patient_hdsr.month).not_to eq 1
      end

      it "redirect to root url when update other patient hdsr" do
        patch patient_hdsr_scale_path(admin_patient, admin_patient_hdsr), params: {
          hdsr_scale: hdsr_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient hdsr" do
        patch patient_hdsr_scale_path(admin_patient, admin_patient_hdsr), params: {
          hdsr_scale: hdsr_scale_params,
        }
        admin_patient_hdsr.reload
        expect(therapist_patient_hdsr.age).not_to eq 1
        expect(therapist_patient_hdsr.year).not_to eq 1
        expect(therapist_patient_hdsr.month).not_to eq 1
      end

      it "redirect to login path when update other patient hdsr" do
        patch patient_hdsr_scale_path(admin_patient, admin_patient_hdsr), params: {
          hdsr_scale: hdsr_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_hdsr) { create(:hdsr_scale, patient: admin_patient) }
    let!(:therapist_patient_hdsr) do
      create(:hdsr_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient hdsr" do
        expect do
          delete patient_hdsr_scale_path(admin_patient, admin_patient_hdsr)
        end.to change(HdsrScale, :count).by(-1)
      end

      it "is success to destor other patient hdsr" do
        expect do
          delete patient_hdsr_scale_path(therapist_patient, therapist_patient_hdsr)
        end.to change(HdsrScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient hdsr" do
        delete patient_hdsr_scale_path(admin_patient, admin_patient_hdsr)
        expect(response).to redirect_to patient_hdsr_scales_path(admin_patient)
      end

      it "is correct message when destroy patient hdsr" do
        delete patient_hdsr_scale_path(admin_patient, admin_patient_hdsr)
        expect(flash[:success]).to eq "HDS-Rを削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient hdsr" do
        expect do
          delete patient_hdsr_scale_path(therapist_patient, therapist_patient_hdsr)
        end.to change(HdsrScale, :count).by(-1)
      end

      it "is false to destor other patient hdsr" do
        expect do
          delete patient_hdsr_scale_path(admin_patient, admin_patient_hdsr)
        end.not_to change(HdsrScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient hdsr" do
        expect do
          delete patient_hdsr_scale_path(admin_patient, admin_patient_hdsr)
        end.not_to change(HdsrScale, :count)
      end

      it "redirect to login path when get edit patient hdsr page" do
        delete patient_hdsr_scale_path(admin_patient, admin_patient_hdsr)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
