require 'rails_helper'

RSpec.describe "TendonReflexScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_tendon_reflex) { create(:tendon_reflex_scale, patient: admin_patient) }
    let!(:therapist_patient_tendon_reflex) do
      create(:tendon_reflex_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient tendon reflex page" do
        get patient_tendon_reflex_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient tendon reflex page" do
        get patient_tendon_reflex_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient tendon reflex page" do
        get patient_tendon_reflex_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient tendon reflex page" do
        get patient_tendon_reflex_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient tendon reflex page" do
        get patient_tendon_reflex_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_tendon_reflex) { create(:tendon_reflex_scale, patient: admin_patient) }
    let!(:therapist_patient_tendon_reflex) do
      create(:tendon_reflex_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient tendon reflex page" do
        get patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        )
        expect(response).to render_template :show
      end

      it "show other patient tendon reflex page" do
        get patient_tendon_reflex_scale_path(
          therapist_patient, therapist_patient_tendon_reflex
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient tendon reflex page" do
        get patient_tendon_reflex_scale_path(
          therapist_patient, therapist_patient_tendon_reflex
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient tendon reflex page" do
        get patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient tendon reflex page" do
        get patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
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

      it "show own patient new tendon reflex scale page" do
        get new_patient_tendon_reflex_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new tendon reflex scale page" do
        get new_patient_tendon_reflex_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new tendon reflex scale page" do
        get new_patient_tendon_reflex_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when show other patient new tendon reflex scale page" do
        get new_patient_tendon_reflex_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get new tendon reflex scale page" do
        get new_patient_tendon_reflex_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:tendon_reflex_scale_params) { attributes_for(:tendon_reflex_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient tendon reflex scale" do
        expect do
          post patient_tendon_reflex_scales_path(admin_patient), params: {
            tendon_reflex_scale: tendon_reflex_scale_params,
          }
        end.to change(TendonReflexScale, :count).by 1
      end

      it "is success to create other patient tendon reflex scale" do
        expect do
          post patient_tendon_reflex_scales_path(therapist_patient), params: {
            tendon_reflex_scale: tendon_reflex_scale_params,
          }
        end.to change(TendonReflexScale, :count).by 1
      end

      it "is redirect to patient page when create tendon reflex scale" do
        post patient_tendon_reflex_scales_path(admin_patient), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        expect(response).to redirect_to patient_tendon_reflex_scales_path(admin_patient)
        expect(flash[:success]).to eq "腱反射を登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient tendon reflex scale" do
        expect do
          post patient_tendon_reflex_scales_path(therapist_patient), params: {
            tendon_reflex_scale: tendon_reflex_scale_params,
          }
        end.to change(TendonReflexScale, :count).by 1
      end

      it "is false to create patient tendon reflex scale" do
        expect do
          post patient_tendon_reflex_scales_path(admin_patient), params: {
            tendon_reflex_scale: tendon_reflex_scale_params,
          }
        end.not_to change(TendonReflexScale, :count)
      end

      it "redirect to root url when create other patient tendon reflex scale" do
        post patient_tendon_reflex_scales_path(
          admin_patient
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient tendon reflex scale" do
        expect do
          post patient_tendon_reflex_scales_path(
            admin_patient
          ), params: {
            tendon_reflex_scale: tendon_reflex_scale_params,
          }
        end.not_to change(TendonReflexScale, :count)
      end

      it "redirect to login path" do
        post patient_tendon_reflex_scales_path(
          admin_patient
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_tendon_reflex) { create(:tendon_reflex_scale, patient: admin_patient) }
    let!(:therapist_patient_tendon_reflex) do
      create(:tendon_reflex_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        )
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_tendon_reflex_scale_path(
          therapist_patient, therapist_patient_tendon_reflex
        )
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_tendon_reflex_scale_path(
          therapist_patient, therapist_patient_tendon_reflex
        )
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient tendon reflex page" do
        get edit_patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient tendon reflex page" do
        get patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_tendon_reflex) do
      create(:tendon_reflex_scale, patient: admin_patient)
    end
    let!(:therapist_patient_tendon_reflex) do
      create(:tendon_reflex_scale, patient: therapist_patient)
    end
    let!(:tendon_reflex_scale_params) do
      attributes_for(:tendon_reflex_scale, jaw: "diminished",
                                           abdominal: "slightly_exaggerated",
                                           right_pectoral: "markedly_exaggerated")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient tendon reflex" do
        patch patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        admin_patient_tendon_reflex.reload
        expect(admin_patient_tendon_reflex.jaw).to eq "diminished"
        expect(admin_patient_tendon_reflex.abdominal).to eq "slightly_exaggerated"
        expect(admin_patient_tendon_reflex.right_pectoral).to eq "markedly_exaggerated"
      end

      it "is redirect to own patient page" do
        patch patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        expect(response).to redirect_to patient_tendon_reflex_scales_path admin_patient
      end

      it "is correct message when success to update own patient tendon reflex" do
        patch patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        expect(flash[:success]).to eq "腱反射を編集しました。"
      end

      it "is success to update other patient tendon reflex" do
        patch patient_tendon_reflex_scale_path(
          therapist_patient, therapist_patient_tendon_reflex
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        therapist_patient_tendon_reflex.reload
        expect(therapist_patient_tendon_reflex.jaw).to eq "diminished"
        expect(therapist_patient_tendon_reflex.abdominal).to eq "slightly_exaggerated"
        expect(therapist_patient_tendon_reflex.right_pectoral).to eq "markedly_exaggerated"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient tendon reflex" do
        patch patient_tendon_reflex_scale_path(
          therapist_patient, therapist_patient_tendon_reflex
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        therapist_patient_tendon_reflex.reload
        expect(therapist_patient_tendon_reflex.jaw).to eq "diminished"
        expect(therapist_patient_tendon_reflex.abdominal).to eq "slightly_exaggerated"
        expect(therapist_patient_tendon_reflex.right_pectoral).to eq "markedly_exaggerated"
      end

      it "is false to update other patient tendon reflex" do
        patch patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        admin_patient_tendon_reflex.reload
        expect(admin_patient_tendon_reflex.jaw).not_to eq "diminished"
        expect(admin_patient_tendon_reflex.abdominal).not_to eq "slightly_exaggerated"
        expect(admin_patient_tendon_reflex.right_pectoral).not_to eq "markedly_exaggerated"
      end

      it "redirect to root url when update other patient tendon reflex" do
        patch patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient tendon reflex" do
        patch patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        admin_patient_tendon_reflex.reload
        expect(therapist_patient_tendon_reflex.jaw).not_to eq "diminished"
        expect(therapist_patient_tendon_reflex.abdominal).not_to eq "slightly_exaggerated"
        expect(therapist_patient_tendon_reflex.right_pectoral).not_to eq "markedly_exaggerated"
      end

      it "redirect to login path when update other patient tendon reflex" do
        patch patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        ), params: {
          tendon_reflex_scale: tendon_reflex_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_tendon_reflex) { create(:tendon_reflex_scale, patient: admin_patient) }
    let!(:therapist_patient_tendon_reflex) do
      create(:tendon_reflex_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient tendon reflex" do
        expect do
          delete patient_tendon_reflex_scale_path(
            admin_patient, admin_patient_tendon_reflex
          )
        end.to change(TendonReflexScale, :count).by(-1)
      end

      it "is success to destor other patient tendon reflex" do
        expect do
          delete patient_tendon_reflex_scale_path(
            therapist_patient, therapist_patient_tendon_reflex
          )
        end.to change(TendonReflexScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient tendon reflex" do
        delete patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        )
        expect(response).to redirect_to patient_tendon_reflex_scales_path(admin_patient)
      end

      it "is correct message when destroy patient tendon reflex" do
        delete patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        )
        expect(flash[:success]).to eq "腱反射を削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient tendon reflex" do
        expect do
          delete patient_tendon_reflex_scale_path(
            therapist_patient, therapist_patient_tendon_reflex
          )
        end.to change(TendonReflexScale, :count).by(-1)
      end

      it "is false to destor other patient tendon reflex" do
        expect do
          delete patient_tendon_reflex_scale_path(
            admin_patient, admin_patient_tendon_reflex
          )
        end.not_to change(TendonReflexScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient tendon reflex" do
        expect do
          delete patient_tendon_reflex_scale_path(
            admin_patient, admin_patient_tendon_reflex
          )
        end.not_to change(TendonReflexScale, :count)
      end

      it "redirect to login path when get edit patient tendon reflex page" do
        delete patient_tendon_reflex_scale_path(
          admin_patient, admin_patient_tendon_reflex
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
