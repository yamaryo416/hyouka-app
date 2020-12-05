class HdsrScalesController < ApplicationController
  before_action :correct_therapist?
  before_action :set_patient
  before_action :set_hdsr_scale, only: [:edit, :update, :destroy]

  def index
    @hdsr_scales = @patient.hdsr_scales.order(created_at: :desc)
  end

  def new
    @hdsr_scale = HdsrScale.new
  end

  def create
    @hdsr_scale = @patient.hdsr_scales.build(hdsr_scale_params)
    if @hdsr_scale.save
      flash[:success] = "HDS-Rを登録しました。"
      redirect_to patient_hdsr_scales_path(@patient)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @hdsr_scale.update(hdsr_scale_params)
      flash[:success] = "HDS-Rを編集しました。"
      redirect_to patient_hdsr_scales_path(@patient)
    else
      render :new
    end
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

  def set_hdsr_scale
    @hdsr_scale = @patient.hdsr_scales.find(params[:id])
  end
end
