class HdsrScalesController < ApplicationController
  before_action :set_hdsr_scale, only: [:show, :edit, :update, :destroy]

  def index
    @hdsr_scales = HdsrScaleDecorator.
      decorate_collection(@patient.hdsr_scales.recent)
  end

  def show
  end

  def new
    @hdsr_scale = HdsrScale.new
  end

  def create
    @hdsr_scale = @patient.hdsr_scales.build(hdsr_scale_params)
    @hdsr_scale.save
    flash[:success] = "HDS-Rを登録しました。"
    redirect_to patient_hdsr_scales_path(@patient)
  end

  def edit
  end

  def update
    @hdsr_scale.update(hdsr_scale_params)
    flash[:success] = "HDS-Rを編集しました。"
    redirect_to patient_hdsr_scales_path(@patient)
  end

  def destroy
    @hdsr_scale.destroy
    flash[:success] = "HDS-Rを削除しました。"
    redirect_to patient_hdsr_scales_path(@patient)
  end

  private

  def hdsr_scale_params
    params.require(:hdsr_scale).permit(:age,
                                       :year,
                                       :month,
                                       :day,
                                       :day_of_the_week,
                                       :place,
                                       :first_three_word,
                                       :second_three_word,
                                       :third_three_word,
                                       :first_subtraction,
                                       :second_subtraction,
                                       :revese_three_number,
                                       :revese_four_number,
                                       :memory_first_word,
                                       :memory_second_word,
                                       :memory_third_word,
                                       :five_goods,
                                       :vegetables)
  end

  def set_hdsr_scale
    @hdsr_scale = @patient.hdsr_scales.find(params[:id]).decorate
  end
end
