class MasScalesController < ApplicationController
  before_action :set_mas_scale, only: [:show, :edit, :update, :destroy]

  def index
    @mas_scales = MasScaleDecorator.
      decorate_collection(@patient.mas_scales.recent)
  end

  def show
  end

  def new
    @mas_scale = MasScale.new.decorate
  end

  def create
    @mas_scale = @patient.mas_scales.build(mas_scale_params)
    @mas_scale.save
    flash[:success] = "MASを登録しました。"
    redirect_to patient_mas_scales_path(@patient)
  end

  def edit
  end

  def update
    @mas_scale.update(mas_scale_params)
    flash[:success] = "MASを編集しました。"
    redirect_to patient_mas_scales_path(@patient)
  end

  def destroy
    @mas_scale.destroy
    flash[:success] = "MASを削除しました。"
    redirect_to patient_mas_scales_path(@patient)
  end

  private

  def mas_scale_params
    params.require(:mas_scale).permit(:right_elbow_joint,
                                      :left_elbow_joint,
                                      :right_wrist_joint,
                                      :left_wrist_joint,
                                      :right_knee_joint,
                                      :left_knee_joint,
                                      :right_ankle_joint,
                                      :left_ankle_joint)
  end

  def set_mas_scale
    @mas_scale = @patient.mas_scales.find(params[:id]).decorate
  end
end
