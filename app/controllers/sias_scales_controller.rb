class SiasScalesController < ApplicationController
  before_action :authenticate_therapist!
  before_action :correct_therapist?
  before_action :set_patient
  before_action :set_sias_scale, only: [:show, :edit, :update, :destroy]
  before_action :already_exist?, only: [:new, :create]

  def show
  end

  def new
    @sias_scale = SiasScale.new
  end

  def create
    @sias_scale = @patient.build_sias_scale(sias_scale_params)
    @sias_scale.patient_id = params[:patient_id]
    @sias_scale.save
    flash[:success] = "SIASを登録しました。"
    redirect_to patient_path(@patient)
  end

  def edit
  end

  def update
    @sias_scale.update(sias_scale_params)
    flash[:success] = "SIASを編集しました。"
    redirect_to patient_sias_scales_path(@patient)
  end

  def destroy
    @sias_scale.destroy
    flash[:success] = "SIASを削除しました。"
    redirect_to patient_path(@patient)
  end

  private

  def sias_scale_params
    params.require(:sias_scale).permit(:shoulder_motor_function,
                                       :finger_motor_function,
                                       :hip_motor_function,
                                       :knee_motor_function,
                                       :foot_motor_function,
                                       :upper_limb_muscle_tone,
                                       :lower_limb_muscle_tone,
                                       :upper_limb_tendon_reflex,
                                       :lower_limb_tendon_reflex,
                                       :upper_limb_tactile,
                                       :lower_limb_tactile,
                                       :upper_limb_sense_of_position,
                                       :lower_limb_sense_of_position,
                                       :shoulder_joint_rom,
                                       :knee_joint_rom,
                                       :pain,
                                       :trunk_verticality,
                                       :abdominal_mmt,
                                       :visuospatial_cognition,
                                       :speech,
                                       :gripstrength,
                                       :quadriceps_mmt)
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

  def set_sias_scale
    @sias_scale = @patient.sias_scale
  end

  def already_exist?
    if @patient.sias_scale
      redirect_to @patient
    end
  end
end
