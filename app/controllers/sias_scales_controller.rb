class SiasScalesController < ApplicationController
  before_action :authenticate_therapist!
  before_action :correct_therapist?
  before_action :set_patient
  before_action :already_exist?

  def new
    @sias_scale = SiasScale.new
  end

  def create
    @sias_scale = @patient.build_sias_scale(create_sias_scale_params)
    @sias_scale.patient_id = params[:patient_id]
    @sias_scale.save
    flash[:success] = "患者番号:#{@patient.unique_id}のSIASを登録しました。"
    redirect_to patients_path
  end

  private

  def create_sias_scale_params
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

  def already_exist?
    if @patient.sias_scale
      redirect_to @patient
    end
  end
end
