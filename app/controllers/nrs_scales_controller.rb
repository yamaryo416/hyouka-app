class NrsScalesController < ApplicationController
  before_action :set_nrs_scale, only: [:edit, :update, :destroy]

  def index
    @nrs_scales = NrsScaleDecorator.
      decorate_collection(@patient.nrs_scales.recent)
  end

  def new
    @nrs_scale = NrsScale.new
  end

  def create
    @nrs_scale = @patient.nrs_scales.build(nrs_scale_params)
    if @nrs_scale.save
      flash[:success] = "NRSを登録しました。"
      redirect_to patient_nrs_scales_path(@patient)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @nrs_scale.update(nrs_scale_params)
      flash[:success] = "NRSを編集しました。"
      redirect_to patient_nrs_scales_path(@patient)
    else
      render :edit
    end
  end

  def destroy
    @nrs_scale.destroy
    flash[:success] = "NRSを削除しました。"
    redirect_to patient_nrs_scales_path(@patient)
  end

  private

  def nrs_scale_params
    params.require(:nrs_scale).permit(:rating,
                                      :status,
                                      :supplement)
  end

  def set_nrs_scale
    @nrs_scale = @patient.nrs_scales.find(params[:id]).decorate
  end
end
