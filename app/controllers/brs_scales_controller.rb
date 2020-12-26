class BrsScalesController < ApplicationController
  before_action :set_brs_scale, only: [:show, :edit, :update, :destroy]

  def index
    @brs_scales = BrsScaleDecorator.
      decorate_collection(@patient.brs_scales.recent)
  end

  def show
  end

  def new
    @brs_scale = BrsScale.new.decorate
  end

  def create
    @brs_scale = @patient.brs_scales.build(brs_scale_params)
    @brs_scale.save
    flash[:success] = "BRSを登録しました。"
    redirect_to patient_brs_scales_path(@patient)
  end

  def edit
  end

  def update
    @brs_scale.update(brs_scale_params)
    flash[:success] = "BRSを編集しました。"
    redirect_to patient_brs_scales_path(@patient)
  end

  def destroy
    @brs_scale.destroy
    flash[:success] = "BRSを削除しました。"
    redirect_to patient_brs_scales_path(@patient)
  end

  private

  def brs_scale_params
    params.require(:brs_scale).permit(:upper_limb,
                                      :finger,
                                      :lower_limb)
  end

  def set_brs_scale
    @brs_scale = @patient.brs_scales.find(params[:id]).decorate
  end
end
