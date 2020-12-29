require 'rails_helper'

RSpec.feature "MasScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_mas) do
    create(:mas_scale, right_elbow_joint: "increase",
                       left_wrist_joint: "mild_increase",
                       right_knee_joint: "significant",
                       patient: second_patient)
  end
  let!(:oldest_third_patient_mas) do
    create(:mas_scale, left_elbow_joint: "mild_enhancement",
                       right_wrist_joint: "mild_increase",
                       left_wrist_joint: "increase",
                       patient: third_patient)
  end
  let!(:thrid_patient_mas) do
    create_list(:mas_scale, 5, right_elbow_joint: "significant", patient: third_patient)
  end
  let!(:latest_third_patient_mas) do
    create(:mas_scale, left_elbow_joint: "rigidity",
                       right_wrist_joint: "increase",
                       left_wrist_joint: "mild_enhancement",
                       right_knee_joint: "rigidity",
                       left_knee_joint: "significant",
                       right_ankle_joint: "mild_increase",
                       left_ankle_joint: "increase",
                       patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient mas" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "MAS"
    expect(page).not_to have_selector ".defined-scale", text: "MAS"
    click_on "MAS"
    expect(page).to have_current_path new_patient_mas_scale_path(first_patient)
    expect(page).to have_selector ".page-title", text: "MAS作成"
    select "2", from: "mas_scale[right_wrist_joint]"
    select "1+", from: "mas_scale[right_knee_joint]"
    select "3", from: "mas_scale[right_ankle_joint]"
    click_on "保存する"
    expect(page).to have_current_path patient_mas_scales_path(first_patient)
    expect(page).to have_selector ".mas0-hypertonia-part", text: "右手関節 右膝関節 右足関節"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient mas" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "MAS"
    expect(page).not_to have_selector ".undefined-scale", text: "MAS"
    click_on "MAS"
    expect(page).to have_current_path patient_mas_scales_path second_patient
    click_on "詳細"
    expect(page).to have_current_path patient_mas_scale_path(
      second_patient, second_patient_mas
    )
    expect(page).to have_selector ".page-title", text: "MAS"
    expect(page).to have_selector ".right_elbow_joint_score",
                                  text: "2"
    expect(page).to have_selector ".left_wrist_joint_score",
                                  text: "1+"
    expect(page).to have_selector ".right_knee_joint_score",
                                  text: "3"
    expect(page).to have_link "MAS一覧"
    expect(page).to have_link "MASを編集"
    expect(page).to have_link "MASを削除"
  end

  scenario "index patient mas" do
    visit patient_mas_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "MAS一覧"
    expect(page).to have_selector ".mas0-hypertonia-part",
                                  text: "左肘関節 右手関節 左手関節 右膝関節 左膝関節 右足関節 左足関節"
    expect(page).to have_selector ".mas6-hypertonia-part",
                                  text: "左肘関節 右手関節 左手関節"
  end

  scenario "edit patient mas" do
    visit patient_mas_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_mas_scale_path(
      second_patient, second_patient_mas
    )
    expect(page).to have_selector ".page-title", text: "MAS編集"
    select "4", from: "mas_scale[right_elbow_joint]"
    select "4", from: "mas_scale[left_wrist_joint]"
    select "4", from: "mas_scale[right_knee_joint]"
    click_on "保存する"
    expect(page).to have_current_path patient_mas_scales_path second_patient
    click_on "詳細"
    expect(page).to have_selector ".right_elbow_joint_score", text: "4"
    expect(page).to have_selector ".left_wrist_joint_score", text: "4"
    expect(page).to have_selector ".right_knee_joint_score", text: "4"
  end

  scenario "destory patient mas", js: true do
    visit patient_mas_scales_path second_patient
    expect(page).to have_selector ".mas0-hypertonia-part",
                                  text: "右肘関節 左手関節 右膝関節"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).to have_current_path patient_mas_scales_path second_patient
    expect(page).not_to have_selector ".mas0-hypertonia-part",
                                      text: "右肘関節 左手関節 右膝関節"
  end

  scenario "show patient page part of bathyesthesia" do
    visit patient_path second_patient
    expect(page).to have_selector ".mas-hypertonia-part-count", text: "筋緊張亢進: 3箇所"
    expect(page).to have_selector ".mas-hypertonia-part", text: "右肘関節 左手関節 右膝関節"
  end
end
