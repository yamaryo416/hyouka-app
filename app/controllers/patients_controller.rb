class PatientsController < ApplicationController
  before_action :correct_therapist?, only: [:show, :edit, :update, :destroy]
  before_action :set_patient, only: [:show, :edit, :update]

  def index
    if current_therapist.has_role? :admin
      @patients = Patient.recent.page(params[:page]).per(10)
    else
      @patients = current_therapist.patients.recent.page(params[:page]).per(10)
    end
  end

  def show
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = current_therapist.patients.new(create_patient_params)
    if @patient.save
      flash[:success] = "患者情報を登録しました。"
      redirect_to @patient
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @patient.update(edit_patient_params)
      flash[:success] = "患者の基本情報を編集しました。"
      redirect_to @patient
    else
      render edit
    end
  end

  def destroy
    Patient.find(params[:id]).destroy
    flash[:success] = "患者情報を削除しました。"
    redirect_to patients_path
  end

  private

  def create_patient_params
    params.require(:patient).permit(:first_name,
                                    :last_name,
                                    :sex,
                                    :age,
                                    :weight,
                                    :height)
  end

  def edit_patient_params
    params.require(:patient).permit(:sex, :age, :weight, :height)
  end

  def correct_therapist?
    if !(current_therapist.patients.include?(Patient.find(params[:id])) ||
      current_therapist.has_role?(:admin))
      redirect_to root_url
    end
  end

  def set_patient
    @patient = Patient.find(params[:id]).decorate
  end
end
