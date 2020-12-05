class FactScalesController < ApplicationController
  before_action :correct_therapist?
  before_action :set_patient
  before_action :set_fact_scale, only: [:show, :edit, :update, :destroy]

  def index
    @fact_scales = @patient.fact_scales.order(created_at: :desc)
  end

  def show
  end

  def new
    @fact_scale = FactScale.new
  end

  def create
    @fact_scale = @patient.fact_scales.build(fact_scale_params)
    if @fact_scale.save
      flash[:success] = "FACTを登録しました。"
      redirect_to patient_fact_scales_path(@patient)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @fact_scale.update(fact_scale_params)
      flash[:success] = "FACTを編集しました。"
      redirect_to patient_fact_scales_path(@patient)
    else
      render :new
    end
  end

  def destroy
    @fact_scale.destroy
    flash[:success] = "FACTを削除しました。"
    redirect_to patient_fact_scales_path(@patient)
  end

  private

  def fact_scale_params
    params.require(:fact_scale).permit(:sitting_with_upper_limb_support,
                                       :sitting_with_no_support,
                                       :lower_lateral_dynamic_sitting,
                                       :forward_dynamic_sitting,
                                       :lateral_dynamic_sitting,
                                       :rear_lateral_dynamic_sitting,
                                       :rear_dynamic_sitting,
                                       :lateral_dynamic_sitting_with_trunk_rotation,
                                       :trunk_rotation,
                                       :trunk_extenxion)
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

  def set_fact_scale
    @fact_scale = @patient.fact_scales.find(params[:id])
  end
end
