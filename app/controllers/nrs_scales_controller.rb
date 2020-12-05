class NrsScalesController < ApplicationController
  before_action :correct_therapist?
  before_action :set_patient
  before_action :set_nrs_scale, only: [:edit, :update, :destroy]

  def index
    @nrs_scales = @patient.nrs_scales.order(created_at: :desc)
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
      render :new
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

  def set_nrs_scale
    @nrs_scale = @patient.nrs_scales.find(params[:id])
  end
end
