class TactileScalesController < ApplicationController
  before_action :correct_therapist?
  before_action :set_patient
  before_action :set_tactile_scale, only: [:show, :edit, :update, :destroy]
  before_action :already_exist?, only: [:new, :create]

  def show
  end

  def new
    @tactile_scale = TactileScale.new
  end

  def create
    @tactile_scale = @patient.build_tactile_scale(tactile_scale_params)
    @tactile_scale.patient_id = params[:patient_id]
    @tactile_scale.save
    flash[:success] = "触覚検査を登録しました。"
    redirect_to patient_path(@patient)
  end

  def edit
  end

  def update
    @tactile_scale.update(tactile_scale_params)
    flash[:success] = "触覚検査を編集しました。"
    redirect_to patient_tactile_scales_path(@patient)
  end

  def destroy
    @tactile_scale.destroy
    flash[:success] = "触覚検査を削除しました。"
    redirect_to patient_path(@patient)
  end

  private

  def tactile_scale_params
    params.require(:tactile_scale).permit(:right_upper_arm,
                                          :left_upper_arm,
                                          :right_forearm,
                                          :left_forearm,
                                          :right_hand,
                                          :left_hand,
                                          :right_thigh,
                                          :left_thigh,
                                          :right_lower_leg,
                                          :left_lower_leg,
                                          :right_rearfoot,
                                          :left_rearfoot,
                                          :right_forefoot,
                                          :left_forefoot)
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

  def set_tactile_scale
    @tactile_scale = @patient.tactile_scale
  end

  def already_exist?
    if @patient.tactile_scale
      redirect_to @patient
    end
  end
end
