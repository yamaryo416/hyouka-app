class TendonReflexScalesController < ApplicationController
  before_action :set_tendon_reflex_scale, only: [:show, :edit, :update, :destroy]

  def index
    @tendon_reflex_scales = TendonReflexScaleDecorator.
      decorate_collection(@patient.tendon_reflex_scales.recent)
  end

  def show
  end

  def new
    @tendon_reflex_scale = TendonReflexScale.new.decorate
  end

  def create
    @tendon_reflex_scale = @patient.tendon_reflex_scales.build(tendon_reflex_scale_params)
    @tendon_reflex_scale.save
    flash[:success] = "腱反射を登録しました。"
    redirect_to patient_tendon_reflex_scales_path(@patient)
  end

  def edit
  end

  def update
    @tendon_reflex_scale.update(tendon_reflex_scale_params)
    flash[:success] = "腱反射を編集しました。"
    redirect_to patient_tendon_reflex_scales_path(@patient)
  end

  def destroy
    @tendon_reflex_scale.destroy
    flash[:success] = "腱反射を削除しました。"
    redirect_to patient_tendon_reflex_scales_path(@patient)
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

  def set_tendon_reflex_scale
    @tendon_reflex_scale = @patient.tendon_reflex_scales.find(params[:id]).
      decorate
  end
end
