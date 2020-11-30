class BestestScalesController < ApplicationController
  before_action :authenticate_therapist!
  before_action :correct_therapist?
  before_action :set_patient
  before_action :set_bestest_scale, only: [:show, :edit, :update, :destroy]

  def index
    @bestest_scales = @patient.bestest_scales.order(created_at: :desc)
  end

  def show
  end

  def new
    @bestest_scale = BestestScale.new
  end

  def create
    @bestest_scale = @patient.bestest_scales.build(bestest_scale_params)
    if @bestest_scale.save
      flash[:success] = "Mini-BESTestを登録しました。"
      redirect_to patient_bestest_scales_path(@patient)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @bestest_scale.update(bestest_scale_params)
      flash[:success] = "Mini-BESTestを編集しました。"
      redirect_to patient_bestest_scales_path(@patient)
    else
      render :new
    end
  end

  def destroy
    @bestest_scale.destroy
    flash[:success] = "Mini-BESTestを削除しました。"
    redirect_to patient_bestest_scales_path(@patient)
  end

  private

  def bestest_scale_params
    params.require(:bestest_scale).permit(:from_sitting_to_standing,
                                          :standing_on_tiptoes,
                                          :standing_on_one_leg,
                                          :forward_step,
                                          :back_step,
                                          :lateral_step,
                                          :standing,
                                          :standing_with_eyes_close,
                                          :standing_on_the_slope,
                                          :change_walking_speed,
                                          :walking_with_rotating_the_head,
                                          :pibot_turn,
                                          :straddling_obstacles,
                                          :tug)
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

  def set_bestest_scale
    @bestest_scale = @patient.bestest_scales.find(params[:id])
  end
end
