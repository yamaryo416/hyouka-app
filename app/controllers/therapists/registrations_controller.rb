# frozen_string_literal: true

class Therapists::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :require_no_authentication, only: [:cancel]
  before_action :creatable?, only: [:new, :create]
  before_action :configure_sign_up_params, only: [:create]
  before_action :not_admin?, only: [:edit, :update]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:unique_id, :first_name, :last_name])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:password, :password_confirmation])
  end

  def after_sign_up_path_for(resource)
    admin_therapists_path
  end

  def after_update_path_for(resource)
    patients_path
  end

  def sign_up(resource_name, resource)
    if !current_therapist_is_admin?
      sign_in(resource_name, resource)
    end
  end

  def creatable?
    if !current_therapist_is_admin?
      redirect_to root_path
    end
  end

  def not_admin?
    redirect_to patients_path if current_therapist_is_admin?
  end
end
