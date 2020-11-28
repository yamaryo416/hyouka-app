class BathyesthesiaScalesController < ApplicationController
  before_action :authenticate_therapist!
  before_action :correct_therapist?
  before_action :set_patient
  before_action :set_bathyesthesia_scale, only: [:show, :edit, :update, :destroy]
  before_action :already_exist?, only: [:new, :create]

  def show
  end

  def new
    @bathyesthesia_scale = BathyesthesiaScale.new
  end

  def create
    @bathyesthesia_scale = @patient.build_bathyesthesia_scale(bathyesthesia_scale_params)
    @bathyesthesia_scale.patient_id = params[:patient_id]
    @bathyesthesia_scale.save
    flash[:success] = "深部感覚検査を登録しました。"
    redirect_to patient_path(@patient)
  end

  def edit
  end

  def update
    @bathyesthesia_scale.update(bathyesthesia_scale_params)
    flash[:success] = "深部感覚検査を編集しました。"
    redirect_to patient_bathyesthesia_scales_path(@patient)
  end

  def destroy
    @bathyesthesia_scale.destroy
    flash[:success] = "深部感覚検査を削除しました。"
    redirect_to patient_path(@patient)
  end

  private

  def bathyesthesia_scale_params
    params.require(:bathyesthesia_scale).permit(:right_upper_limb,
                                                :left_upper_limb,
                                                :right_lower_limb,
                                                :left_lower_limb,
                                                :right_finger,
                                                :left_finger,
                                                :right_toe,
                                                :left_toe)
  end

  def correct_therapist?
    if !(current_therapist.patients.include?(Patient.find(params[:patient_id])) ||
      current_therapist.has_role?(:admin))
      redirect_to root_url
    end
  end

  def set_patient
    if current_therapist.has_role?(:admin)
      @patient = Patient.find(params[:patient_id])
    else
      @patient = current_therapist.patients.find(params[:patient_id])
    end
  end

  def set_bathyesthesia_scale
    @bathyesthesia_scale = @patient.bathyesthesia_scale
  end

  def already_exist?
    if @patient.bathyesthesia_scale
      redirect_to @patient
    end
  end
end
