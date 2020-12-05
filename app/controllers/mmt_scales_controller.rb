class MmtScalesController < ApplicationController
  before_action :correct_therapist?
  before_action :set_patient
  before_action :set_mmt_scale, only: [:show, :edit, :update, :destroy]
  before_action :already_exist?, only: [:new, :create]

  def show
  end

  def new
    @mmt_scale = MmtScale.new
  end

  def create
    @mmt_scale = @patient.build_mmt_scale(mmt_scale_params)
    @mmt_scale.patient_id = params[:patient_id]
    @mmt_scale.save
    flash[:success] = "MMTを登録しました。"
    redirect_to patient_path(@patient)
  end

  def edit
  end

  def update
    @mmt_scale.update(mmt_scale_params)
    flash[:success] = "MMTを編集しました。"
    redirect_to patient_mmt_scales_path(@patient)
  end

  def destroy
    @mmt_scale.destroy
    flash[:success] = "MMTを削除しました。"
    redirect_to patient_path(@patient)
  end

  private

  def mmt_scale_params
    params.require(:mmt_scale).permit(:neck_flexion,
                                      :neck_extension,
                                      :trunk_flexion,
                                      :trunk_extension,
                                      :right_shoulder_flexion,
                                      :left_shoulder_flexion,
                                      :right_shoulder_extension,
                                      :left_shoulder_extension,
                                      :right_shoulder_abduction,
                                      :left_shoulder_abduction,
                                      :right_shoulder_horizontal_adduction,
                                      :left_shoulder_horizontal_adduction,
                                      :right_shoulder_horizontal_abduction,
                                      :left_shoulder_horizontal_abduction,
                                      :right_shoulder_internal_rotation,
                                      :left_shoulder_internal_rotation,
                                      :right_shoulder_external_rotation,
                                      :left_shoulder_external_rotation,
                                      :right_elbow_flexion,
                                      :left_elbow_flexion,
                                      :right_elbow_extension,
                                      :left_elbow_extension,
                                      :right_forearm_pronation,
                                      :left_forearm_pronation,
                                      :right_forearm_supination,
                                      :left_forearm_supination,
                                      :right_wrist_flexion,
                                      :left_wrist_flexion,
                                      :right_wrist_extension,
                                      :left_wrist_extension,
                                      :right_first_hip_flexion,
                                      :left_first_hip_flexion,
                                      :right_second_hip_flexion,
                                      :left_second_hip_flexion,
                                      :right_first_hip_extension,
                                      :left_first_hip_extension,
                                      :right_second_hip_extension,
                                      :left_second_hip_extension,
                                      :right_hip_adduction,
                                      :left_hip_adduction,
                                      :right_first_hip_abduction,
                                      :left_first_hip_abduction,
                                      :right_second_hip_abduction,
                                      :left_second_hip_abduction,
                                      :right_hip_internal_rotation,
                                      :left_hip_internal_rotation,
                                      :right_hip_external_rotation,
                                      :left_hip_external_rotation,
                                      :right_knee_flexion,
                                      :left_knee_flexion,
                                      :right_knee_extension,
                                      :left_knee_extension,
                                      :right_ankle_flexion,
                                      :left_ankle_flexion,
                                      :right_ankle_extension,
                                      :left_ankle_extension,
                                      :right_ankle_pronation,
                                      :left_ankle_pronation,
                                      :right_ankle_supination,
                                      :left_ankle_supination)
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

  def set_mmt_scale
    @mmt_scale = @patient.mmt_scale
  end

  def already_exist?
    if @patient.mmt_scale
      redirect_to @patient
    end
  end
end
