class MasScalesController < ApplicationController
  before_action :set_mas_scale, only: [:show, :edit, :update, :destroy]
  before_action :already_exist?, only: [:new, :create]

  def show
  end

  def new
    @mas_scale = MasScale.new
  end

  def create
    @mas_scale = @patient.build_mas_scale(mas_scale_params)
    @mas_scale.patient_id = params[:patient_id]
    @mas_scale.save
    flash[:success] = "MASを登録しました。"
    redirect_to patient_path(@patient)
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
    redirect_to patient_path(@patient)
  end

  private

  def mas_scale_params
    params.require(:mas_scale).permit(:elbow_joint,
                                      :wrist_joint,
                                      :knee_joint,
                                      :ankle_joint)
  end

  def set_mas_scale
    @mas_scale = @patient.mas_scale
  end

  def already_exist?
    if @patient.mas_scale
      redirect_to @patient
    end
  end
end
