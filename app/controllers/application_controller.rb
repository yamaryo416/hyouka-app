class ApplicationController < ActionController::Base
  before_action :authenticate_therapist!
  before_action :correct_therapist?, unless: :devise_controller?
  before_action :set_patient, unless: :devise_controller?

  private

  def current_therapist_is_admin?
    therapist_signed_in? && current_therapist.has_role?(:admin)
  end

  def correct_therapist?
    if !(current_therapist.patients.include?(Patient.find(params[:patient_id])) ||
      current_therapist.has_role?(:admin))
      redirect_to root_url
    end
  end

  def set_patient
    if current_therapist.has_role?(:admin)
      @patient = Patient.find(params[:patient_id]).decorate
    else
      @patient = current_therapist.patients.find(params[:patient_id]).decorate
    end
  end
end
