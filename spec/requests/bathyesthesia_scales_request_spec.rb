require 'rails_helper'

RSpec.describe "BathyesthesiaScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_bathyesthesia) { create(:bathyesthesia_scale, patient: admin_patient) }
    let!(:therapist_patient_bathyesthesia) do
      create(:bathyesthesia_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient bathyesthesia page" do
        get patient_bathyesthesia_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient bathyesthesia page" do
        get patient_bathyesthesia_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient bathyesthesia page" do
        get patient_bathyesthesia_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient bathyesthesia page" do
        get patient_bathyesthesia_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient bathyesthesia page" do
        get patient_bathyesthesia_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_bathyesthesia) { create(:bathyesthesia_scale, patient: admin_patient) }
    let!(:therapist_patient_bathyesthesia) do
      create(:bathyesthesia_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient bathyesthesia page" do
        get patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        )
        expect(response).to render_template :show
      end

      it "show other patient bathyesthesia page" do
        get patient_bathyesthesia_scale_path(
          therapist_patient, therapist_patient_bathyesthesia
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient bathyesthesia page" do
        get patient_bathyesthesia_scale_path(
          therapist_patient, therapist_patient_bathyesthesia
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient bathyesthesia page" do
        get patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient bathyesthesia page" do
        get patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
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

      it "show own patient new bathyesthesia scale page" do
        get new_patient_bathyesthesia_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new bathyesthesia scale page" do
        get new_patient_bathyesthesia_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new bathyesthesia scale page" do
        get new_patient_bathyesthesia_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when get other patient new bathyesthesia scale page" do
        get new_patient_bathyesthesia_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path" do
        get new_patient_bathyesthesia_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:bathyesthesia_scale_params) { attributes_for(:bathyesthesia_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient bathyesthesia scale" do
        expect do
          post patient_bathyesthesia_scales_path(admin_patient), params: {
            bathyesthesia_scale: bathyesthesia_scale_params,
          }
        end.to change(BathyesthesiaScale, :count).by 1
      end

      it "is success to create other patient bathyesthesia scale" do
        expect do
          post patient_bathyesthesia_scales_path(therapist_patient), params: {
            bathyesthesia_scale: bathyesthesia_scale_params,
          }
        end.to change(BathyesthesiaScale, :count).by 1
      end

      it "is redirect to patient page when create bathyesthesia scale" do
        post patient_bathyesthesia_scales_path(admin_patient), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        expect(response).to redirect_to patient_bathyesthesia_scales_path(admin_patient)
        expect(flash[:success]).to eq "深部感覚検査を登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient bathyesthesia scale" do
        expect do
          post patient_bathyesthesia_scales_path(
            therapist_patient
          ), params: {
            bathyesthesia_scale: bathyesthesia_scale_params,
          }
        end.to change(BathyesthesiaScale, :count).by 1
      end

      it "is false to create patient bathyesthesia scale" do
        expect do
          post patient_bathyesthesia_scales_path(
            admin_patient
          ), params: {
            bathyesthesia_scale: bathyesthesia_scale_params,
          }
        end.not_to change(BathyesthesiaScale, :count)
      end

      it "redirect to root url when create other patient bathyesthesia scale" do
        post patient_bathyesthesia_scales_path(
          admin_patient
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient bathyesthesia scale" do
        expect do
          post patient_bathyesthesia_scales_path(
            admin_patient
          ), params: {
            bathyesthesia_scale: bathyesthesia_scale_params,
          }
        end.not_to change(BathyesthesiaScale, :count)
      end

      it "redirect to login path" do
        post patient_bathyesthesia_scales_path(
          admin_patient
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_bathyesthesia) { create(:bathyesthesia_scale, patient: admin_patient) }
    let!(:therapist_patient_bathyesthesia) do
      create(:bathyesthesia_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        )
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_bathyesthesia_scale_path(
          therapist_patient, therapist_patient_bathyesthesia
        )
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_bathyesthesia_scale_path(
          therapist_patient, therapist_patient_bathyesthesia
        )
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient bathyesthesia page" do
        get edit_patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient bathyesthesia page" do
        get patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_bathyesthesia) { create(:bathyesthesia_scale, patient: admin_patient) }
    let!(:therapist_patient_bathyesthesia) do
      create(:bathyesthesia_scale, patient: therapist_patient)
    end
    let!(:bathyesthesia_scale_params) do
      attributes_for(:bathyesthesia_scale, right_upper_limb: "impaired",
                                           left_upper_limb: "impaired",
                                           right_lower_limb: "normal")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient bathyesthesia" do
        patch patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        admin_patient_bathyesthesia.reload
        expect(admin_patient_bathyesthesia.right_upper_limb).to eq "impaired"
        expect(admin_patient_bathyesthesia.left_upper_limb).to eq "impaired"
        expect(admin_patient_bathyesthesia.right_lower_limb).to eq "normal"
      end

      it "is redirect to own patient page" do
        patch patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        expect(response).to redirect_to patient_bathyesthesia_scales_path admin_patient
      end

      it "is correct message when success to update own patient bathyesthesia" do
        patch patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        expect(flash[:success]).to eq "深部感覚検査を編集しました。"
      end

      it "is success to update other patient bathyesthesia" do
        patch patient_bathyesthesia_scale_path(
          therapist_patient, therapist_patient_bathyesthesia
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        therapist_patient_bathyesthesia.reload
        expect(therapist_patient_bathyesthesia.right_upper_limb).to eq "impaired"
        expect(therapist_patient_bathyesthesia.left_upper_limb).to eq "impaired"
        expect(therapist_patient_bathyesthesia.right_lower_limb).to eq "normal"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient bathyesthesia" do
        patch patient_bathyesthesia_scale_path(
          therapist_patient, therapist_patient_bathyesthesia
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        therapist_patient_bathyesthesia.reload
        expect(therapist_patient_bathyesthesia.right_upper_limb).to eq "impaired"
        expect(therapist_patient_bathyesthesia.left_upper_limb).to eq "impaired"
        expect(therapist_patient_bathyesthesia.right_lower_limb).to eq "normal"
      end

      it "is false to update other patient bathyesthesia" do
        patch patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        admin_patient_bathyesthesia.reload
        expect(admin_patient_bathyesthesia.right_upper_limb).not_to eq "impaired"
        expect(admin_patient_bathyesthesia.left_upper_limb).not_to eq "impaired"
        expect(admin_patient_bathyesthesia.right_lower_limb).not_to eq "normal"
      end

      it "redirect to root url when update other patient bathyesthesia" do
        patch patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient bathyesthesia" do
        patch patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        admin_patient_bathyesthesia.reload
        expect(therapist_patient_bathyesthesia.right_upper_limb).not_to eq "impaired"
        expect(therapist_patient_bathyesthesia.left_upper_limb).not_to eq "impaired"
        expect(therapist_patient_bathyesthesia.right_lower_limb).not_to eq "normal"
      end

      it "redirect to login path when update other patient bathyesthesia" do
        patch patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        ), params: {
          bathyesthesia_scale: bathyesthesia_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_bathyesthesia) { create(:bathyesthesia_scale, patient: admin_patient) }
    let!(:therapist_patient_bathyesthesia) do
      create(:bathyesthesia_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient bathyesthesia" do
        expect do
          delete patient_bathyesthesia_scale_path(
            admin_patient, admin_patient_bathyesthesia
          )
        end.to change(BathyesthesiaScale, :count).by(-1)
      end

      it "is success to destor other patient bathyesthesia" do
        expect do
          delete patient_bathyesthesia_scale_path(
            therapist_patient, therapist_patient_bathyesthesia
          )
        end.to change(BathyesthesiaScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient bathyesthesia" do
        delete patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        )
        expect(response).to redirect_to patient_bathyesthesia_scales_path(admin_patient)
      end

      it "is correct message when destroy patient bathyesthesia" do
        delete patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        )
        expect(flash[:success]).to eq "深部感覚検査を削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient bathyesthesia" do
        expect do
          delete patient_bathyesthesia_scale_path(
            therapist_patient, therapist_patient_bathyesthesia
          )
        end.to change(BathyesthesiaScale, :count).by(-1)
      end

      it "is false to destor other patient bathyesthesia" do
        expect do
          delete patient_bathyesthesia_scale_path(
            admin_patient, admin_patient_bathyesthesia
          )
        end.not_to change(BathyesthesiaScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient bathyesthesia" do
        expect do
          delete patient_bathyesthesia_scale_path(
            admin_patient, admin_patient_bathyesthesia
          )
        end.not_to change(BathyesthesiaScale, :count)
      end

      it "redirect to login path when get edit patient bathyesthesia page" do
        delete patient_bathyesthesia_scale_path(
          admin_patient, admin_patient_bathyesthesia
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
