class BathyesthesiaScalesController < ApplicationController
  before_action :set_bathyesthesia_scale, only: [:show, :edit, :update, :destroy]

  def index
    @bathyesthesia_scales = BathyesthesiaScaleDecorator.
      decorate_collection(@patient.bathyesthesia_scales.recent)
  end

  def show
  end

  def new
    @bathyesthesia_scale = BathyesthesiaScale.new.decorate
  end

  def create
    @bathyesthesia_scale = @patient.bathyesthesia_scales.build(bathyesthesia_scale_params)
    @bathyesthesia_scale.save
    flash[:success] = "深部感覚検査を登録しました。"
    redirect_to patient_bathyesthesia_scales_path(@patient)
  end

  def edit
  end

  def update
    @bathyesthesia_scale.update(bathyesthesia_scale_params)
    flash[:success] = "深部感覚検査を編集しました。"
    redirect_to patient_bathyesthesia_scales_path(@patient)
  end

  def destroy
    @bathyesthesia_scale.destroy
    flash[:success] = "深部感覚検査を削除しました。"
    redirect_to patient_bathyesthesia_scales_path(@patient)
  end

  private

  def bathyesthesia_scale_params
    params.require(:bathyesthesia_scale).permit(:right_upper_limb,
                                                :left_upper_limb,
                                                :right_lower_limb,
                                                :left_lower_limb,
                                                :right_finger,
                                                :left_finger,
                                                :right_toe,
                                                :left_toe)
  end

  def set_bathyesthesia_scale
    @bathyesthesia_scale = @patient.bathyesthesia_scales.find(params[:id]).decorate
  end
end
