class FbsScalesController < ApplicationController
  before_action :set_fbs_scale, only: [:show, :edit, :update, :destroy]

  def index
    @fbs_scales = FbsScaleDecorator.
      decorate_collection(@patient.fbs_scales.recent)
  end

  def show
  end

  def new
    @fbs_scale = FbsScale.new.decorate
  end

  def create
    @fbs_scale = @patient.fbs_scales.build(fbs_scale_params)
    @fbs_scale.save
    flash[:success] = "FBSを登録しました。"
    redirect_to patient_fbs_scales_path(@patient)
  end

  def edit
  end

  def update
    @fbs_scale.update(fbs_scale_params)
    flash[:success] = "FBSを編集しました。"
    redirect_to patient_fbs_scales_path(@patient)
  end

  def destroy
    @fbs_scale.destroy
    flash[:success] = "FBSを削除しました。"
    redirect_to patient_fbs_scales_path(@patient)
  end

  private

  def fbs_scale_params
    params.require(:fbs_scale).permit(:stand_up,
                                      :standing,
                                      :sitting,
                                      :sit_down,
                                      :transfer,
                                      :standing_with_eyes_close,
                                      :standing_with_leg_close,
                                      :reach_forward,
                                      :pickup_from_floor,
                                      :turn_around,
                                      :one_rotation,
                                      :stepup_and_down,
                                      :tandem_standing,
                                      :standing_with_one_leg)
  end

  def set_fbs_scale
    @fbs_scale = @patient.fbs_scales.find(params[:id]).decorate
  end
end
