require 'rails_helper'

RSpec.describe "Patients", type: :request do
  let!(:admin) { create(:therapist, :admin) }
  let!(:admin_patient) { create(:patient, sex: :man, age: 20, weight: 60.0, height: 170.0, therapist: admin) }
  let!(:therapist) { create(:therapist) }
  let!(:therapist_patient)  { create(:patient, sex: :woman, age: 30, weight: 55.0, height: 160.0, therapist: therapist) }

  describe "#index" do
    context "login as admin" do
      before do
        sign_in admin
        get patients_path
      end

      it "show patients page" do
        expect(response).to render_template :index
      end

      it "show correct page content" do
        expect(response.body).to include admin_patient.unique_id
        expect(response.body).to include therapist_patient.unique_id
      end
    end

    context "login as correct therapist" do
      before do
        sign_in therapist
        get patients_path
      end

      it "show patients page" do
        expect(response).to render_template :index
      end

      it "show correct page content" do
        expect(response.body).to include therapist_patient.unique_id
        expect(response.body).not_to include admin_patient.unique_id
      end
    end

    context "not login" do
      it "redirect root url" do
        get patients_path
      end
    end
  end

  describe "#show" do
    context "login as admin" do
      before do
        sign_in admin
      end

      it "show own patient page" do
        get patient_path admin_patient
        expect(response).to render_template :show
      end

      it "show correct page content in own patient page" do
        get patient_path admin_patient
        expect(response.body).to include admin_patient.unique_id
      end

      it "show therapist patient page" do
        get patient_path therapist_patient
        expect(response).to render_template :show
      end

      it "show correct page content in therapist patient page" do
        get patient_path therapist_patient
        expect(response.body).to include therapist_patient.unique_id
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show own patient page" do
        get patient_path therapist_patient
        expect(response).to render_template :show
      end

      it "show correct page content in own patient page" do
        get patient_path therapist_patient
        expect(response.body).to include therapist_patient.unique_id
      end

      it "redirect to root url when not own patient page" do
        get patient_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path" do
        get patient_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#new" do
    context "login" do
      it "show new page" do
        sign_in admin
        get new_patient_path
        expect(response).to render_template :new
      end
    end

    context "not login" do
      it "redirect to login path" do
        get new_patient_path
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#create" do
    let!(:patient_params) { attributes_for(:patient) }
    let!(:invalid_patient_params) { attributes_for(:patient, unique_id: "") }

    context "login" do
      before do
        sign_in admin
      end

      context "if the parameter is valid" do
        it "is success to create patient" do
          expect do
            post patients_path, params: { patient: patient_params }
          end.to change(Patient, :count).by 1
        end

        it "is correct message" do
          post patients_path, params: { patient: patient_params }
          expect(flash[:success]).to eq "患者情報を登録しました。"
        end
      end

      context "if the parameter is invalid" do
        it "is false to create patient" do
          expect do
            post patients_path, params: { patient: invalid_patient_params }
          end.not_to change(Patient, :count)
        end

        it "render patient new page" do
          post patients_path, params: { patient: invalid_patient_params }
          expect(response).to render_template :new
        end
      end
    end

    context "not login" do
      it "is false to create patient" do
        expect do
          post patients_path, params: { patient: patient_params }
        end.not_to change(Patient, :count)
      end

      it "redirect to login path" do
        post patients_path, params: { patient: patient_params }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#edit" do
    context "login as admin" do
      before do
        sign_in admin
      end

      it "show edit page in own patient page" do
        get edit_patient_path admin_patient
        expect(response).to render_template :edit
      end

      it "show correct page content in own patient page" do
        get edit_patient_path admin_patient
        expect(response.body).to include admin_patient.unique_id
      end

      it "show edit page in other patient page" do
        get edit_patient_path therapist_patient
        expect(response).to render_template :edit
      end

      it "show correct page content in other patient page" do
        get edit_patient_path therapist_patient
        expect(response.body).to include therapist_patient.unique_id
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "show edit page in own patient page" do
        get edit_patient_path therapist_patient
        expect(response).to render_template :edit
      end

      it "show correct page content in own patient page" do
        get edit_patient_path therapist_patient
        expect(response.body).to include therapist_patient.unique_id
      end

      it "redirect to root url when not own patient page get" do
        get edit_patient_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "redirect to login path" do
        get edit_patient_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#update" do
    context "login as admin" do
      before do
        sign_in admin
      end
      it "is success to update own patient" do
        patch patient_path(admin_patient), params: { patient: { sex: :woman,
                                                                age: 50,
                                                                weight: 55.5,
                                                                height: 175.5
                                                                } }
        admin_patient.reload
        expect(admin_patient.sex).to eq "woman"
        expect(admin_patient.age).to eq 50
        expect(admin_patient.weight).to eq 55.5
        expect(admin_patient.height).to eq 175.5
      end

      it "is redirect to own patient page" do
        patch patient_path(admin_patient), params: { patient: { sex: :woman } }
        expect(response).to redirect_to patient_path admin_patient
      end

      it "is success to update other patient page" do
        patch patient_path(therapist_patient), params: { patient: { sex: :man,
                                                                age: 40,
                                                                weight: 70.0,
                                                                height: 165.5
                                                                } }
        therapist_patient.reload
        expect(therapist_patient.sex).to eq "man"
        expect(therapist_patient.age).to eq 40
        expect(therapist_patient.weight).to eq 70.0
        expect(therapist_patient.height).to eq 165.5
      end

      it "is redirect to other patient page" do
        patch patient_path(therapist_patient), params: { patient: { sex: :woman } }
        therapist_patient.reload
        expect(response).to redirect_to patient_path therapist_patient
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end
      it "is success to update own patient" do
        patch patient_path(therapist_patient), params: { patient: { sex: :man,
                                                                age: 45,
                                                                weight: 45.5,
                                                                height: 180.5
                                                                } }
        therapist_patient.reload
        expect(therapist_patient.sex).to eq "man"
        expect(therapist_patient.age).to eq 45
        expect(therapist_patient.weight).to eq 45.5
        expect(therapist_patient.height).to eq 180.5
      end

      it "redirect to own patient page" do
        patch patient_path(therapist_patient), params: { patient: { sex: :man } }
        therapist_patient.reload
        expect(response).to redirect_to patient_path therapist_patient
      end

      it "redirect root url when when not own patient page get" do
        patch patient_path(admin_patient), params: { patient: { sex: :woman } }
        expect(response).to redirect_to root_url
      end
    end
    context "not login" do
      it "redirect root url when when not own patient page get" do
        patch patient_path(admin_patient), params: { patient: { sex: :woman } }
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    context "login as admin" do
      before do
        sign_in admin
      end

      it "is success to destroy own patient" do
        expect do
          delete patient_path admin_patient
        end.to change(Patient, :count).by -1
      end

      it "redirect patients path when destroy own patient" do
        delete patient_path admin_patient
        expect(response).to redirect_to patients_path
      end

      it "is success to destroy other patient" do
        expect do
          delete patient_path therapist_patient
        end.to change(Patient, :count).by -1
      end

      it "redirect patients path when destroy other patient" do
        delete patient_path therapist_patient
        expect(response).to redirect_to patients_path
      end
    end

    context "login as therapist" do
      before do
        sign_in therapist
      end

      it "is success to destroy own patient" do
        expect do
          delete patient_path therapist_patient
        end.to change(Patient, :count).by -1
      end

      it "redirect patients path when destroy own patient" do
        delete patient_path therapist_patient
        expect(response).to redirect_to patients_path
      end

      it "is false to destroy other patient" do
        expect do
          delete patient_path admin_patient
        end.not_to change(Patient, :count)
      end

      it "redirect root url" do
        delete patient_path admin_patient
        expect(response).to redirect_to root_url
      end
    end

    context "not login" do
      it "is false to destroy a patient" do
        expect do
          delete patient_path admin_patient
        end.not_to change(Patient, :count)
      end

      it "redirect root url" do
        delete patient_path admin_patient
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
