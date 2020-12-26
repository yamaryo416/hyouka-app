class RomScalesController < ApplicationController
  before_action :set_rom_scale, only: [:show, :edit, :update, :destroy]

  def index
    @rom_scales = RomScaleDecorator.
      decorate_collection(@patient.rom_scales.recent)
  end

  def show
  end

  def new
    @rom_scale = RomScale.new.decorate
  end

  def create
    @rom_scale = @patient.rom_scales.build(rom_scale_params)
    @rom_scale.save
    flash[:success] = "ROMを登録しました。"
    redirect_to patient_rom_scales_path(@patient)
  end

  def edit
  end

  def update
    @rom_scale.update(rom_scale_params)
    flash[:success] = "ROMを編集しました。"
    redirect_to patient_rom_scales_path(@patient)
  end

  def destroy
    @rom_scale.destroy
    flash[:success] = "ROMを削除しました。"
    redirect_to patient_rom_scales_path(@patient)
  end

  private

  def rom_scale_params
    params.require(:rom_scale).permit(:right_shoulder_flexion,
                                      :left_shoulder_flexion,
                                      :right_shoulder_extension,
                                      :left_shoulder_extension,
                                      :right_shoulder_adduction,
                                      :left_shoulder_adduction,
                                      :right_shoulder_abduction,
                                      :left_shoulder_abduction,
                                      :right_first_shoulder_internal_rotation,
                                      :left_first_shoulder_internal_rotation,
                                      :right_first_shoulder_external_rotation,
                                      :left_first_shoulder_external_rotation,
                                      :right_second_shoulder_internal_rotation,
                                      :left_second_shoulder_internal_rotation,
                                      :right_second_shoulder_external_rotation,
                                      :left_second_shoulder_external_rotation,
                                      :right_third_shoulder_internal_rotation,
                                      :left_third_shoulder_internal_rotation,
                                      :right_third_shoulder_external_rotation,
                                      :left_third_shoulder_external_rotation,
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
                                      :right_wrist_adduction,
                                      :left_wrist_adduction,
                                      :right_wrist_abduction,
                                      :left_wrist_abduction,
                                      :right_hip_flexion,
                                      :left_hip_flexion,
                                      :right_hip_extension,
                                      :left_hip_extension,
                                      :right_hip_adduction,
                                      :left_hip_adduction,
                                      :right_hip_abduction,
                                      :left_hip_abduction,
                                      :right_hip_internal_rotation,
                                      :left_hip_internal_rotation,
                                      :right_hip_external_rotation,
                                      :left_hip_external_rotation,
                                      :right_knee_flexion,
                                      :left_knee_flexion,
                                      :right_knee_extension,
                                      :left_knee_extension,
                                      :right_first_ankle_flexion,
                                      :left_first_ankle_flexion,
                                      :right_second_ankle_flexion,
                                      :left_second_ankle_flexion,
                                      :right_ankle_extension,
                                      :left_ankle_extension,
                                      :right_ankle_adduction,
                                      :left_ankle_adduction,
                                      :right_ankle_abduction,
                                      :left_ankle_abduction,
                                      :right_ankle_pronation,
                                      :left_ankle_pronation,
                                      :right_ankle_supination,
                                      :left_ankle_supination)
  end

  def set_rom_scale
    @rom_scale = @patient.rom_scales.find(params[:id]).decorate
  end
end
