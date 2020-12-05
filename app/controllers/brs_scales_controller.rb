class BrsScalesController < ApplicationController
  before_action :correct_therapist?
  before_action :set_patient
  before_action :set_brs_scale, only: [:show, :edit, :update, :destroy]
  before_action :already_exist?, only: [:new, :create]

  def show
  end

  def new
    @brs_scale = BrsScale.new
  end

  def create
    @brs_scale = @patient.build_brs_scale(brs_scale_params)
    @brs_scale.patient_id = params[:patient_id]
    @brs_scale.save
    flash[:success] = "BRSを登録しました。"
    redirect_to patient_path(@patient)
  end

  def edit
  end

  def update
    @brs_scale.update(brs_scale_params)
    flash[:success] = "BRSを編集しました。"
    redirect_to patient_brs_scales_path(@patient)
  end

  def destroy
    @brs_scale.destroy
    flash[:success] = "BRSを削除しました。"
    redirect_to patient_path(@patient)
  end

  private

  def brs_scale_params
    params.require(:brs_scale).permit(:upper_limbs,
                                      :finger,
                                      :lower_limbs)
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

  def set_brs_scale
    @brs_scale = @patient.brs_scale
  end

  def already_exist?
    if @patient.brs_scale
      redirect_to @patient
    end
  end
end
