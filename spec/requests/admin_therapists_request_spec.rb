require "rails_helper"

RSpec.describe "Admin::Therapists", type: :request do
  describe "#index" do
    context "login as admin" do
      let!(:admin) { create(:therapist, :admin) }

      it "show index page" do
        sign_in admin
        get admin_therapists_path
        expect(response).to render_template :index
      end
    end

    context "login as therapist" do
      let!(:therapist) { create(:therapist) }

      it "redirect to patients page" do
        sign_in therapist
        get admin_therapists_path
        expect(response).to redirect_to patients_path
      end
    end

    context "not login" do
      it "redirect to root url" do
        get admin_therapists_path
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#show" do
    context "login as admin" do
      let!(:admin) { create(:therapist, :admin) }

      it "show index page" do
        sign_in admin
        get admin_therapist_path admin
        expect(response).to render_template :show
      end
    end

    context "login as therapist" do
      let!(:therapist) { create(:therapist) }

      it "redirect to patients page" do
        sign_in therapist
        get admin_therapist_path therapist
        expect(response).to redirect_to patients_path
      end
    end

    context "not login" do
      let!(:therapist) { create(:therapist) }

      it "redirect to root url" do
        get admin_therapist_path therapist
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end

  describe "#destroy" do
    context "login as admin" do
      let!(:admin) { create(:therapist, :admin) }

      before do
        sign_in admin
      end

      context "destroy admin" do
        it "is false to destroy admin" do
          expect do
            delete admin_therapist_path(admin)
          end.not_to change(Therapist, :count)
        end
        it "is redirect to show admin page" do
          delete admin_therapist_path(admin)
          expect(response).to redirect_to admin_therapist_path admin
        end
      end

      context "delete therapist" do
        let!(:therapist) { create(:therapist) }

        it "is success to destroy therapist" do
          expect do
            delete admin_therapist_path(therapist)
          end.to change(Therapist, :count).by(-1)
        end
        it "is redirect to therapists page" do
          delete admin_therapist_path(therapist)
          expect(response).to redirect_to admin_therapists_path
        end
      end
    end

    context "login as therapist" do
      let!(:first_therapist) { create(:therapist) }
      let!(:second_therapist) { create(:therapist) }

      before do
        sign_in first_therapist
      end

      it "is false to destroy therapist" do
        expect do
          delete admin_therapist_path(second_therapist)
        end.not_to change(Therapist, :count)
      end
      it "is redirect to therapists page" do
        delete admin_therapist_path(second_therapist)
        expect(response).to redirect_to patients_path
      end
    end

    context "not login" do
      let!(:therapist) { create(:therapist) }

      it "is false to destroy therapist" do
        expect do
          delete admin_therapist_path(therapist)
        end.not_to change(Therapist, :count)
      end
      it "is redirect to root url" do
        delete admin_therapist_path(therapist)
        expect(response).to redirect_to new_therapist_session_path
      end
    end
  end
end
