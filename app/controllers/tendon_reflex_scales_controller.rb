class TendonReflexScalesController < ApplicationController
  before_action :authenticate_therapist!
  before_action :correct_therapist?
  before_action :set_patient
  before_action :set_tendon_reflex_scale, only: [:show, :edit, :update, :destroy]
  before_action :already_exist?, only: [:new, :create]

  def show
  end

  def new
    @tendon_reflex_scale = TendonReflexScale.new
  end

  def create
    @tendon_reflex_scale = @patient.build_tendon_reflex_scale(tendon_reflex_scale_params)
    @tendon_reflex_scale.patient_id = params[:patient_id]
    @tendon_reflex_scale.save
    flash[:success] = "深部腱反射を登録しました。"
    redirect_to patient_path(@patient)
  end

  def edit
  end

  def update
    @tendon_reflex_scale.update(tendon_reflex_scale_params)
    flash[:success] = "深部腱反射を編集しました。"
    redirect_to patient_tendon_reflex_scales_path(@patient)
  end

  def destroy
    @tendon_reflex_scale.destroy
    flash[:success] = "深部腱反射を削除しました。"
    redirect_to patient_path(@patient)
  end

  private

  def tendon_reflex_scale_params
    params.require(:tendon_reflex_scale).permit(:jaw,
                                                :abdominal,
                                                :right_pectoral,
                                                :left_pectoral,
                                                :right_biceps,
                                                :left_biceps,
                                                :right_biceps,
                                                :left_biceps,
                                                :right_triceps,
                                                :left_triceps,
                                                :right_brachioradialis,
                                                :left_brachioradialis,
                                                :right_pronator,
                                                :left_pronator,
                                                :right_patellar_tendon,
                                                :left_patellar_tendon,
                                                :right_achilles_tendon,
                                                :left_achilles_tendon)
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

  def set_tendon_reflex_scale
    @tendon_reflex_scale = @patient.tendon_reflex_scale
  end

  def already_exist?
    if @patient.tendon_reflex_scale
      redirect_to @patient
    end
  end
end
