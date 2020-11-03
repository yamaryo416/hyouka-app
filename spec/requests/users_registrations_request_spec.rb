require "rails_helper"

RSpec.describe "UsersRegistrations", type: :request do
  describe "Get #new" do
    context "login as admin" do
      let!(:admin) { create(:user, :admin) }

      it "show singup page" do
        sign_in admin
        get signup_path
        expect(response).to render_template :new
      end
    end

    context "login as user" do
      let!(:user) { create(:user) }

      it "redirect root_path" do
        sign_in user
        get signup_path
        expect(response).to redirect_to root_path
      end
    end

    context "not login" do
      it "redirect root_path" do
        get signup_path
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "Post #create" do
    context "login as admin" do
      let!(:admin) { create(:user, :admin) }
      let!(:user_params) { attributes_for(:user) }
      let!(:invalid_user_params) { attributes_for(:user, user_id: "") }
      before do
        sign_in admin
      end

      context "if the parameter is valid" do
        it "is success to create user" do
          expect do
            post user_registration_path, params: { user: user_params }
          end.to change(User, :count).by 1
        end
        it "redirect to root_path" do
          post user_registration_path, params: { user: user_params }
          expect(response).to redirect_to root_path
        end
      end

      context "if the parameter is invalid" do
        it "is false to create user" do
          expect do
            post user_registration_path, params: { user: invalid_user_params }
          end.to_not change(User, :count)
        end
        it "render signup page" do
          post user_registration_path, params: { user: invalid_user_params }
          expect(response).to render_template :new
        end
      end
    end

    context "login as user" do
      let!(:user) { create(:user) }
      let!(:user_params) { attributes_for(:user) }
      it "is false to create user" do
        sign_in user
        expect do
          post user_registration_path, params: { user: user_params }
        end.to_not change(User, :count)
      end
    end

    context "not login" do
      let!(:user_params) { attributes_for(:user) }
      it "is false to create user" do
        expect do
          post user_registration_path, params: { user: user_params }
        end.to_not change(User, :count)
      end
    end
  end
end
