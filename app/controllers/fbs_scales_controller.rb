class FbsScalesController < ApplicationController
  before_action :set_fbs_scale, only: [:show, :edit, :update, :destroy]
  before_action :already_exist?, only: [:new, :create]

  def show
  end

  def new
    @fbs_scale = FbsScale.new
  end

  def create
    @fbs_scale = @patient.build_fbs_scale(fbs_scale_params)
    @fbs_scale.patient_id = params[:patient_id]
    @fbs_scale.save
    flash[:success] = "FBSを登録しました。"
    redirect_to patient_path(@patient)
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
    redirect_to patient_path(@patient)
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
    @fbs_scale = @patient.fbs_scale
  end

  def already_exist?
    if @patient.fbs_scale
      redirect_to @patient
    end
  end
end
