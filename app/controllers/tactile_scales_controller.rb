class TactileScalesController < ApplicationController
  before_action :set_tactile_scale, only: [:show, :edit, :update, :destroy]

  def index
    @tactile_scales = TactileScaleDecorator.
      decorate_collection(@patient.tactile_scales.recent)
  end

  def show
  end

  def new
    @tactile_scale = TactileScale.new.decorate
  end

  def create
    @tactile_scale = @patient.tactile_scales.build(tactile_scale_params)
    @tactile_scale.save
    flash[:success] = "触覚検査を登録しました。"
    redirect_to patient_tactile_scales_path(@patient)
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
    redirect_to patient_tactile_scales_path(@patient)
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

  def set_tactile_scale
    @tactile_scale = @patient.tactile_scales.find(params[:id]).decorate
  end
end
