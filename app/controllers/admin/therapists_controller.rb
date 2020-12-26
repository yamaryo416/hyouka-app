class Admin::TherapistsController < ApplicationController
  before_action :authenticate?
  skip_before_action :correct_therapist?
  skip_before_action :set_patient

  def index
    @therapists = Therapist.recent.page(params[:page]).per(10)
  end

  def show
    @therapist = Therapist.find(params[:id]).decorate
  end

  def destroy
    therapist = Therapist.find(params[:id])
    if therapist.has_role?(:admin)
      flash[:danger] = "管理者は削除できません"
      redirect_to admin_therapist_path(params[:id])
    else
      therapist.destroy
      flash[:success] = "ユーザーを削除しました。"
      redirect_to admin_therapists_path
    end
  end

  private

  def authenticate?
    redirect_to patients_path unless current_therapist_is_admin?
  end
end
