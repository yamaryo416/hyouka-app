require 'rails_helper'

RSpec.describe "TactileScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_tactile) { create(:tactile_scale, patient: admin_patient) }
    let!(:therapist_patient_tactile) do
      create(:tactile_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient tactile page" do
        get patient_tactile_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient tactile page" do
        get patient_tactile_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient tactile page" do
        get patient_tactile_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient tactile page" do
        get patient_tactile_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient tactile page" do
        get patient_tactile_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_tactile) { create(:tactile_scale, patient: admin_patient) }
    let!(:therapist_patient_tactile) do
      create(:tactile_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient tactile page" do
        get patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        )
        expect(response).to render_template :show
      end

      it "show other patient tactile page" do
        get patient_tactile_scale_path(
          therapist_patient, therapist_patient_tactile
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient tactile page" do
        get patient_tactile_scale_path(
          therapist_patient, therapist_patient_tactile
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient tactile page" do
        get patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient tactile page" do
        get patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
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

      it "show own patient new tactile scale page" do
        get new_patient_tactile_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new tactile scale page" do
        get new_patient_tactile_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new tactile scale page" do
        get new_patient_tactile_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when get other patient new tactile scale page" do
        get new_patient_tactile_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path" do
        get new_patient_tactile_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:tactile_scale_params) { attributes_for(:tactile_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient tactile scale" do
        expect do
          post patient_tactile_scales_path(admin_patient), params: {
            tactile_scale: tactile_scale_params,
          }
        end.to change(TactileScale, :count).by 1
      end

      it "is success to create other patient tactile scale" do
        expect do
          post patient_tactile_scales_path(therapist_patient), params: {
            tactile_scale: tactile_scale_params,
          }
        end.to change(TactileScale, :count).by 1
      end

      it "is redirect to patient page when create tactile scale" do
        post patient_tactile_scales_path(admin_patient), params: {
          tactile_scale: tactile_scale_params,
        }
        expect(response).to redirect_to patient_tactile_scales_path(admin_patient)
        expect(flash[:success]).to eq "触覚検査を登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient tactile scale" do
        expect do
          post patient_tactile_scales_path(therapist_patient), params: {
            tactile_scale: tactile_scale_params,
          }
        end.to change(TactileScale, :count).by 1
      end

      it "is false to create patient tactile scale" do
        expect do
          post patient_tactile_scales_path(admin_patient), params: {
            tactile_scale: tactile_scale_params,
          }
        end.not_to change(TactileScale, :count)
      end

      it "redirect to root url when create other patient tactile scale" do
        post patient_tactile_scales_path(
          admin_patient
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient tactile scale" do
        expect do
          post patient_tactile_scales_path(
            admin_patient
          ), params: {
            tactile_scale: tactile_scale_params,
          }
        end.not_to change(TactileScale, :count)
      end

      it "redirect to login path" do
        post patient_tactile_scales_path(
          admin_patient
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_tactile) { create(:tactile_scale, patient: admin_patient) }
    let!(:therapist_patient_tactile) do
      create(:tactile_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        )
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_tactile_scale_path(
          therapist_patient, therapist_patient_tactile
        )
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_tactile_scale_path(
          therapist_patient, therapist_patient_tactile
        )
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient tactile page" do
        get edit_patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient tactile page" do
        get patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_tactile) { create(:tactile_scale, patient: admin_patient) }
    let!(:therapist_patient_tactile) do
      create(:tactile_scale, patient: therapist_patient)
    end
    let!(:tactile_scale_params) do
      attributes_for(:tactile_scale, right_upper_arm: "absent",
                                     left_upper_arm: "impaired",
                                     right_forearm: "normal")
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient tactile" do
        patch patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        admin_patient_tactile.reload
        expect(admin_patient_tactile.right_upper_arm).to eq "absent"
        expect(admin_patient_tactile.left_upper_arm).to eq "impaired"
        expect(admin_patient_tactile.right_forearm).to eq "normal"
      end

      it "is redirect to own patient page" do
        patch patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        expect(response).to redirect_to patient_tactile_scales_path admin_patient
      end

      it "is correct message when success to update own patient tactile" do
        patch patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        expect(flash[:success]).to eq "触覚検査を編集しました。"
      end

      it "is success to update other patient tactile" do
        patch patient_tactile_scale_path(
          therapist_patient, therapist_patient_tactile
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        therapist_patient_tactile.reload
        expect(therapist_patient_tactile.right_upper_arm).to eq "absent"
        expect(therapist_patient_tactile.left_upper_arm).to eq "impaired"
        expect(therapist_patient_tactile.right_forearm).to eq "normal"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient tactile" do
        patch patient_tactile_scale_path(
          therapist_patient, therapist_patient_tactile
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        therapist_patient_tactile.reload
        expect(therapist_patient_tactile.right_upper_arm).to eq "absent"
        expect(therapist_patient_tactile.left_upper_arm).to eq "impaired"
        expect(therapist_patient_tactile.right_forearm).to eq "normal"
      end

      it "is false to update other patient tactile" do
        patch patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        admin_patient_tactile.reload
        expect(admin_patient_tactile.right_upper_arm).not_to eq "absent"
        expect(admin_patient_tactile.left_upper_arm).not_to eq "impaired"
        expect(admin_patient_tactile.right_forearm).not_to eq "normal"
      end

      it "redirect to root url when update other patient tactile" do
        patch patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient tactile" do
        patch patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        admin_patient_tactile.reload
        expect(therapist_patient_tactile.right_upper_arm).not_to eq "absent"
        expect(therapist_patient_tactile.left_upper_arm).not_to eq "impaired"
        expect(therapist_patient_tactile.right_forearm).not_to eq "normal"
      end

      it "redirect to login path when update other patient tactile" do
        patch patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        ), params: {
          tactile_scale: tactile_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_tactile) { create(:tactile_scale, patient: admin_patient) }
    let!(:therapist_patient_tactile) do
      create(:tactile_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient tactile" do
        expect do
          delete patient_tactile_scale_path(
            admin_patient, admin_patient_tactile
          )
        end.to change(TactileScale, :count).by(-1)
      end

      it "is success to destor other patient tactile" do
        expect do
          delete patient_tactile_scale_path(
            therapist_patient, therapist_patient_tactile
          )
        end.to change(TactileScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient tactile" do
        delete patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        )
        expect(response).to redirect_to patient_tactile_scales_path(admin_patient)
      end

      it "is correct message when destroy patient tactile" do
        delete patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        )
        expect(flash[:success]).to eq "触覚検査を削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient tactile" do
        expect do
          delete patient_tactile_scale_path(
            therapist_patient, therapist_patient_tactile
          )
        end.to change(TactileScale, :count).by(-1)
      end

      it "is false to destor other patient tactile" do
        expect do
          delete patient_tactile_scale_path(
            admin_patient, admin_patient_tactile
          )
        end.not_to change(TactileScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient tactile" do
        expect do
          delete patient_tactile_scale_path(
            admin_patient, admin_patient_tactile
          )
        end.not_to change(TactileScale, :count)
      end

      it "redirect to login path when get edit patient tactile page" do
        delete patient_tactile_scale_path(
          admin_patient, admin_patient_tactile
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
