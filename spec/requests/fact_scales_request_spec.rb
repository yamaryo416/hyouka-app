require 'rails_helper'

RSpec.describe "FactScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_fact) { create(:fact_scale, patient: admin_patient) }
    let!(:therapist_patient_fact) do
      create(:fact_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient fact page" do
        get patient_fact_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient fact page" do
        get patient_fact_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient fact page" do
        get patient_fact_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient fact page" do
        get patient_fact_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient fact page" do
        get patient_fact_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_fact) { create(:fact_scale, patient: admin_patient) }
    let!(:therapist_patient_fact) do
      create(:fact_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient fact page" do
        get patient_fact_scale_path(admin_patient, admin_patient_fact)
        expect(response).to render_template :show
      end

      it "show other patient fact page" do
        get patient_fact_scale_path(
          therapist_patient, therapist_patient_fact
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient fact page" do
        get patient_fact_scale_path(
          therapist_patient, therapist_patient_fact
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient fact page" do
        get patient_fact_scale_path(admin_patient, admin_patient_fact)
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient fact page" do
        get patient_fact_scale_path(admin_patient, admin_patient_fact)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#new" do
    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient new fact scale page" do
        get new_patient_fact_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new fact scale page" do
        get new_patient_fact_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new fact scale page" do
        get new_patient_fact_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when show other patient new fact scale page" do
        get new_patient_fact_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get new fact scale page" do
        get new_patient_fact_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:fact_scale_params) { attributes_for(:fact_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient fact scale" do
        expect do
          post patient_fact_scales_path(admin_patient), params: {
            fact_scale: fact_scale_params,
          }
        end.to change(FactScale, :count).by 1
      end

      it "is success to create other patient fact scale" do
        expect do
          post patient_fact_scales_path(therapist_patient), params: {
            fact_scale: fact_scale_params,
          }
        end.to change(FactScale, :count).by 1
      end

      it "is redirect to patient page when create fact scale" do
        post patient_fact_scales_path(admin_patient), params: {
          fact_scale: fact_scale_params,
        }
        expect(response).to redirect_to patient_fact_scales_path(admin_patient)
        expect(flash[:success]).to eq "FACTを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient fact scale" do
        expect do
          post patient_fact_scales_path(therapist_patient), params: {
            fact_scale: fact_scale_params,
          }
        end.to change(FactScale, :count).by 1
      end

      it "is false to create patient fact scale" do
        expect do
          post patient_fact_scales_path(admin_patient), params: {
            fact_scale: fact_scale_params,
          }
        end.not_to change(FactScale, :count)
      end

      it "redirect to root url when create other patient fact scale" do
        post patient_fact_scales_path(admin_patient), params: {
          fact_scale: fact_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient fact scale" do
        expect do
          post patient_fact_scales_path(admin_patient), params: {
            fact_scale: fact_scale_params,
          }
        end.not_to change(FactScale, :count)
      end

      it "redirect to login path" do
        post patient_fact_scales_path(admin_patient), params: {
          fact_scale: fact_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_fact) { create(:fact_scale, patient: admin_patient) }
    let!(:therapist_patient_fact) do
      create(:fact_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_fact_scale_path(admin_patient, admin_patient_fact)
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_fact_scale_path(therapist_patient, therapist_patient_fact)
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_fact_scale_path(therapist_patient, therapist_patient_fact)
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient fact page" do
        get edit_patient_fact_scale_path(admin_patient, admin_patient_fact)
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient fact page" do
        get edit_patient_fact_scale_path(admin_patient, admin_patient_fact)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_fact) { create(:fact_scale, patient: admin_patient) }
    let!(:therapist_patient_fact) do
      create(:fact_scale, patient: therapist_patient)
    end
    let!(:fact_scale_params) do
      attributes_for(:fact_scale, sitting_with_upper_limb_support: "possible",
                                  sitting_with_no_support: "possible",
                                  lower_lateral_dynamic_sitting: "possible")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient fact" do
        patch patient_fact_scale_path(admin_patient, admin_patient_fact), params: {
          fact_scale: fact_scale_params,
        }
        admin_patient_fact.reload
        expect(admin_patient_fact.sitting_with_upper_limb_support).to eq "possible"
        expect(admin_patient_fact.sitting_with_no_support).to eq "possible"
        expect(admin_patient_fact.lower_lateral_dynamic_sitting).to eq "possible"
      end

      it "is redirect to own patient fact page" do
        patch patient_fact_scale_path(admin_patient, admin_patient_fact), params: {
          fact_scale: fact_scale_params,
        }
        expect(response).to redirect_to patient_fact_scales_path admin_patient
      end

      it "is correct message when success to update own patient fact" do
        patch patient_fact_scale_path(admin_patient, admin_patient_fact), params: {
          fact_scale: fact_scale_params,
        }
        expect(flash[:success]).to eq "FACTを編集しました。"
      end

      it "is success to update other patient fact" do
        patch patient_fact_scale_path(therapist_patient, therapist_patient_fact), params: {
          fact_scale: fact_scale_params,
        }
        therapist_patient_fact.reload
        expect(therapist_patient_fact.sitting_with_upper_limb_support).to eq "possible"
        expect(therapist_patient_fact.sitting_with_no_support).to eq "possible"
        expect(therapist_patient_fact.lower_lateral_dynamic_sitting).to eq "possible"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient fact" do
        patch patient_fact_scale_path(therapist_patient, therapist_patient_fact), params: {
          fact_scale: fact_scale_params,
        }
        therapist_patient_fact.reload
        expect(therapist_patient_fact.sitting_with_upper_limb_support).to eq "possible"
        expect(therapist_patient_fact.sitting_with_no_support).to eq "possible"
        expect(therapist_patient_fact.lower_lateral_dynamic_sitting).to eq "possible"
      end

      it "is false to update other patient fact" do
        patch patient_fact_scale_path(admin_patient, admin_patient_fact), params: {
          fact_scale: fact_scale_params,
        }
        admin_patient_fact.reload
        expect(admin_patient_fact.sitting_with_upper_limb_support).not_to eq "possible"
        expect(admin_patient_fact.sitting_with_no_support).not_to eq "possible"
        expect(admin_patient_fact.lower_lateral_dynamic_sitting).not_to eq "possible"
      end

      it "redirect to root url when update other patient fact" do
        patch patient_fact_scale_path(admin_patient, admin_patient_fact), params: {
          fact_scale: fact_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient fact" do
        patch patient_fact_scale_path(admin_patient, admin_patient_fact), params: {
          fact_scale: fact_scale_params,
        }
        admin_patient_fact.reload
        expect(therapist_patient_fact.sitting_with_upper_limb_support).not_to eq "possible"
        expect(therapist_patient_fact.sitting_with_no_support).not_to eq "possible"
        expect(therapist_patient_fact.lower_lateral_dynamic_sitting).not_to eq "possible"
      end

      it "redirect to login path when update other patient fact" do
        patch patient_fact_scale_path(admin_patient, admin_patient_fact), params: {
          fact_scale: fact_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_fact) { create(:fact_scale, patient: admin_patient) }
    let!(:therapist_patient_fact) do
      create(:fact_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient fact" do
        expect do
          delete patient_fact_scale_path(admin_patient, admin_patient_fact)
        end.to change(FactScale, :count).by(-1)
      end

      it "is success to destor other patient fact" do
        expect do
          delete patient_fact_scale_path(therapist_patient, therapist_patient_fact)
        end.to change(FactScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient fact" do
        delete patient_fact_scale_path(admin_patient, admin_patient_fact)
        expect(response).to redirect_to patient_fact_scales_path(admin_patient)
      end

      it "is correct message when destroy patient fact" do
        delete patient_fact_scale_path(admin_patient, admin_patient_fact)
        expect(flash[:success]).to eq "FACTを削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient fact" do
        expect do
          delete patient_fact_scale_path(therapist_patient, therapist_patient_fact)
        end.to change(FactScale, :count).by(-1)
      end

      it "is false to destor other patient fact" do
        expect do
          delete patient_fact_scale_path(admin_patient, admin_patient_fact)
        end.not_to change(FactScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient fact" do
        expect do
          delete patient_fact_scale_path(admin_patient, admin_patient_fact)
        end.not_to change(FactScale, :count)
      end

      it "redirect to login path when get edit patient fact page" do
        delete patient_fact_scale_path(admin_patient, admin_patient_fact)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
