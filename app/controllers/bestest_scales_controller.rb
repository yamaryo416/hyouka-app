class BestestScalesController < ApplicationController
  before_action :set_bestest_scale, only: [:show, :edit, :update, :destroy]

  def index
    @bestest_scales = BestestScaleDecorator.
      decorate_collection(@patient.bestest_scales.recent)
  end

  def show
  end

  def new
    @bestest_scale = BestestScale.new
  end

  def create
    @bestest_scale = @patient.bestest_scales.build(bestest_scale_params)
    @bestest_scale.save
    flash[:success] = "Mini-BESTestを登録しました。"
    redirect_to patient_bestest_scales_path(@patient)
  end

  def edit
  end

  def update
    @bestest_scale.update(bestest_scale_params)
    flash[:success] = "Mini-BESTestを編集しました。"
    redirect_to patient_bestest_scales_path(@patient)
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

  def set_bestest_scale
    @bestest_scale = @patient.bestest_scales.find(params[:id]).decorate
  end
end
