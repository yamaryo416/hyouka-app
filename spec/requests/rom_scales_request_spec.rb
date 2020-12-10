require 'rails_helper'

RSpec.describe "RomScales", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient) { create(:patient, therapist: therapist) }

  describe "#index" do
    let!(:admin_patient_rom) { create(:rom_scale, patient: admin_patient) }
    let!(:therapist_patient_rom) do
      create(:rom_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient rom page" do
        get patient_rom_scales_path admin_patient
        expect(response).to render_template :index
      end

      it "show other patient rom page" do
        get patient_rom_scales_path therapist_patient
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient rom page" do
        get patient_rom_scales_path therapist_patient
        expect(response).to render_template :index
      end

      it "redirect to root url when get other patient rom page" do
        get patient_rom_scales_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient rom page" do
        get patient_rom_scales_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    let!(:admin_patient_rom) { create(:rom_scale, patient: admin_patient) }
    let!(:therapist_patient_rom) do
      create(:rom_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient rom page" do
        get patient_rom_scale_path(
          admin_patient, admin_patient_rom
        )
        expect(response).to render_template :show
      end

      it "show other patient rom page" do
        get patient_rom_scale_path(
          therapist_patient, therapist_patient_rom
        )
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient rom page" do
        get patient_rom_scale_path(
          therapist_patient, therapist_patient_rom
        )
        expect(response).to render_template :show
      end

      it "redirect to root url when get other patient rom page" do
        get patient_rom_scale_path(
          admin_patient, admin_patient_rom
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get patient rom page" do
        get patient_rom_scale_path(
          admin_patient, admin_patient_rom
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

      it "show own patient new rom scale page" do
        get new_patient_rom_scale_path admin_patient
        expect(response).to render_template :new
      end

      it "show other patient new rom scale page" do
        get new_patient_rom_scale_path therapist_patient
        expect(response).to render_template :new
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient new rom scale page" do
        get new_patient_rom_scale_path therapist_patient
        expect(response).to render_template :new
      end

      it "redirect to root url when get other patient new rom scale page" do
        get new_patient_rom_scale_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path" do
        get new_patient_rom_scale_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#ceate" do
    let!(:rom_scale_params) { attributes_for(:rom_scale) }

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to create own patient rom scale" do
        expect do
          post patient_rom_scales_path(admin_patient), params: {
            rom_scale: rom_scale_params,
          }
        end.to change(RomScale, :count).by 1
      end

      it "is success to create other patient rom scale" do
        expect do
          post patient_rom_scales_path(therapist_patient), params: {
            rom_scale: rom_scale_params,
          }
        end.to change(RomScale, :count).by 1
      end

      it "is redirect to patient page when create rom scale" do
        post patient_rom_scales_path(admin_patient), params: {
          rom_scale: rom_scale_params,
        }
        expect(response).to redirect_to patient_rom_scales_path(admin_patient)
        expect(flash[:success]).to eq "ROMを登録しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to create own patient rom scale" do
        expect do
          post patient_rom_scales_path(therapist_patient), params: {
            rom_scale: rom_scale_params,
          }
        end.to change(RomScale, :count).by 1
      end

      it "is false to create patient rom scale" do
        expect do
          post patient_rom_scales_path(admin_patient), params: {
            rom_scale: rom_scale_params,
          }
        end.not_to change(RomScale, :count)
      end

      it "redirect to root url when create other patient rom scale" do
        post patient_rom_scales_path(admin_patient), params: { rom_scale: rom_scale_params }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to create patient rom scale" do
        expect do
          post patient_rom_scales_path(admin_patient), params: {
            rom_scale: rom_scale_params,
          }
        end.not_to change(RomScale, :count)
      end

      it "redirect to login path" do
        post patient_rom_scales_path(admin_patient), params: { rom_scale: rom_scale_params }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    let!(:admin_patient_rom) { create(:rom_scale, patient: admin_patient) }
    let!(:therapist_patient_rom) do
      create(:rom_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_rom_scale_path(
          admin_patient, admin_patient_rom
        )
        expect(response).to render_template :edit
      end

      it "show edit page in other patient page" do
        get edit_patient_rom_scale_path(
          therapist_patient, therapist_patient_rom
        )
        expect(response).to render_template :edit
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_rom_scale_path(
          therapist_patient, therapist_patient_rom
        )
        expect(response).to render_template :edit
      end

      it "redirect to root url when get edit other patient rom page" do
        get edit_patient_rom_scale_path(
          admin_patient, admin_patient_rom
        )
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path when get edit patient rom page" do
        get patient_rom_scale_path(
          admin_patient, admin_patient_rom
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    let!(:admin_patient_rom) { create(:rom_scale, patient: admin_patient) }
    let!(:therapist_patient_rom) do
      create(:rom_scale, patient: therapist_patient)
    end
    let!(:rom_scale_params) do
      attributes_for(:rom_scale, right_shoulder_flexion: 90,
                                 left_shoulder_flexion: 60,
                                 right_shoulder_extension: 45)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to update own patient rom" do
        patch patient_rom_scale_path(
          admin_patient, admin_patient_rom
        ), params: {
          rom_scale: rom_scale_params,
        }
        admin_patient_rom.reload
        expect(admin_patient_rom.right_shoulder_flexion).to eq 90
        expect(admin_patient_rom.left_shoulder_flexion).to eq 60
        expect(admin_patient_rom.right_shoulder_extension).to eq 45
      end

      it "is redirect to own patient page" do
        patch patient_rom_scale_path(
          admin_patient, admin_patient_rom
        ), params: {
          rom_scale: rom_scale_params,
        }
        expect(response).to redirect_to patient_rom_scales_path admin_patient
      end

      it "is correct message when success to update own patient rom" do
        patch patient_rom_scale_path(
          admin_patient, admin_patient_rom
        ), params: {
          rom_scale: rom_scale_params,
        }
        expect(flash[:success]).to eq "ROMを編集しました。"
      end

      it "is success to update other patient rom" do
        patch patient_rom_scale_path(
          therapist_patient, therapist_patient_rom
        ), params: {
          rom_scale: rom_scale_params,
        }
        therapist_patient_rom.reload
        expect(therapist_patient_rom.right_shoulder_flexion).to eq 90
        expect(therapist_patient_rom.left_shoulder_flexion).to eq 60
        expect(therapist_patient_rom.right_shoulder_extension).to eq 45
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to update own patient rom" do
        patch patient_rom_scale_path(
          therapist_patient, therapist_patient_rom
        ), params: {
          rom_scale: rom_scale_params,
        }
        therapist_patient_rom.reload
        expect(therapist_patient_rom.right_shoulder_flexion).to eq 90
        expect(therapist_patient_rom.left_shoulder_flexion).to eq 60
        expect(therapist_patient_rom.right_shoulder_extension).to eq 45
      end

      it "is false to update other patient rom" do
        patch patient_rom_scale_path(
          admin_patient, admin_patient_rom
        ), params: {
          rom_scale: rom_scale_params,
        }
        admin_patient_rom.reload
        expect(therapist_patient_rom.right_shoulder_flexion).not_to eq 90
        expect(therapist_patient_rom.left_shoulder_flexion).not_to eq 60
        expect(therapist_patient_rom.right_shoulder_extension).not_to eq 45
      end

      it "redirect to root url when update other patient rom" do
        patch patient_rom_scale_path(
          admin_patient, admin_patient_rom
        ), params: {
          rom_scale: rom_scale_params,
        }
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "false to update patient rom" do
        patch patient_rom_scale_path(
          admin_patient, admin_patient_rom
        ), params: {
          rom_scale: rom_scale_params,
        }
        admin_patient_rom.reload
        expect(therapist_patient_rom.right_shoulder_flexion).not_to eq 90
        expect(therapist_patient_rom.left_shoulder_flexion).not_to eq 60
        expect(therapist_patient_rom.right_shoulder_extension).not_to eq 45
      end

      it "redirect to login path when update other patient rom" do
        patch patient_rom_scale_path(
          admin_patient, admin_patient_rom
        ), params: {
          rom_scale: rom_scale_params,
        }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    let!(:admin_patient_rom) { create(:rom_scale, patient: admin_patient) }
    let!(:therapist_patient_rom) do
      create(:rom_scale, patient: therapist_patient)
    end

    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destor own patient rom" do
        expect do
          delete patient_rom_scale_path(
            admin_patient, admin_patient_rom
          )
        end.to change(RomScale, :count).by(-1)
      end

      it "is success to destor other patient rom" do
        expect do
          delete patient_rom_scale_path(
            therapist_patient, therapist_patient_rom
          )
        end.to change(RomScale, :count).by(-1)
      end

      it "redirect patients path when destroy own patient rom" do
        delete patient_rom_scale_path(
          admin_patient, admin_patient_rom
        )
        expect(response).to redirect_to patient_rom_scales_path(admin_patient)
      end

      it "is correct message when destroy patient rom" do
        delete patient_rom_scale_path(
          admin_patient, admin_patient_rom
        )
        expect(flash[:success]).to eq "ROMを削除しました。"
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destor own patient rom" do
        expect do
          delete patient_rom_scale_path(
            therapist_patient, therapist_patient_rom
          )
        end.to change(RomScale, :count).by(-1)
      end

      it "is false to destor other patient rom" do
        expect do
          delete patient_rom_scale_path(
            admin_patient, admin_patient_rom
          )
        end.not_to change(RomScale, :count)
      end
    end

    context "not login" do
      it "is false to destor patient rom" do
        expect do
          delete patient_rom_scale_path(
            admin_patient, admin_patient_rom
          )
        end.not_to change(RomScale, :count)
      end

      it "redirect to login path when get edit patient rom page" do
        delete patient_rom_scale_path(
          admin_patient, admin_patient_rom
        )
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
