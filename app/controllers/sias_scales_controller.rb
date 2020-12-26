class SiasScalesController < ApplicationController
  before_action :set_sias_scale, only: [:show, :edit, :update, :destroy]

  def index
    @sias_scales = SiasScaleDecorator.
      decorate_collection(@patient.sias_scales.recent)
  end

  def show
  end

  def new
    @sias_scale = SiasScale.new
  end

  def create
    @sias_scale = @patient.sias_scales.build(sias_scale_params)
    @sias_scale.save
    flash[:success] = "SIASを登録しました。"
    redirect_to patient_sias_scales_path(@patient)
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
    redirect_to patient_sias_scales_path(@patient)
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

  def set_sias_scale
    @sias_scale = @patient.sias_scales.find(params[:id]).decorate
  end
end
