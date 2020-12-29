require "rails_helper"

RSpec.feature "MmtScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_mmt) do
    create(:mmt_scale, right_shoulder_flexion: "zero",
                       right_hip_adduction: "trace",
                       left_ankle_extension: "trace_poor",
                       patient: second_patient)
  end
  let!(:oldest_third_patient_mmt) do
    create(:mmt_scale, neck_flexion: "zero",
                       neck_extension: "poor",
                       left_wrist_flexion: "trace",
                       right_wrist_extension: "poor",
                       right_shoulder_horizontal_adduction: "trace",
                       left_shoulder_horizontal_adduction: "fair",
                       patient: third_patient)
  end
  let!(:third_patient_mmts) do
    create_list(:mmt_scale, 5, left_first_hip_extension: "zero", patient: third_patient)
  end
  let!(:latest_third_patient_mmt) do
    create(:mmt_scale, left_shoulder_external_rotation: "trace",
                       right_elbow_flexion: "zero",
                       left_forearm_pronation: "poor",
                       right_forearm_supination: "fair",
                       left_forearm_supination: "zero",
                       patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient mmt" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "MMT"
    expect(page).not_to have_selector ".defined-scale", text: "MMT"
    click_on "MMT"
    expect(page).to have_current_path new_patient_mmt_scale_path(first_patient)
    expect(page).to have_selector ".page-title", text: "MMT作成"
    select "0", from: "mmt_scale[neck_flexion]"
    select "3", from: "mmt_scale[left_shoulder_external_rotation]"
    select "2-", from: "mmt_scale[right_ankle_extension]"
    click_on "保存する"
    expect(page).to have_current_path patient_mmt_scales_path(first_patient)
    expect(page).to have_selector ".mmt0-weak-part-count",
                                  text: "3箇所に筋力低下があります。"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient mmt" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "MMT"
    expect(page).not_to have_selector ".undefined-scale", text: "MMT"
    click_on "MMT"
    expect(page).to have_current_path patient_mmt_scales_path second_patient
    click_on "詳細"
    expect(page).to have_current_path patient_mmt_scale_path(
      second_patient, second_patient_mmt
    )
    expect(page).to have_selector ".page-title", text: "MMT"
    expect(page).to have_selector ".weak-part-detail",
                                  text: "右肩関節屈曲 右股関節内転 右足関節底屈"
    expect(page).to have_selector ".right_shoulder_flexion_score", text: "0"
    expect(page).to have_selector ".right_hip_adduction_score", text: "1"
    expect(page).to have_selector ".left_ankle_extension_score", text: "2-"
    expect(page).to have_link "MMT一覧"
    expect(page).to have_link "MMTを編集"
    expect(page).to have_link "MMTを削除"
  end

  scenario "index patient mmt" do
    visit patient_mmt_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "MMT一覧"
    expect(page).to have_selector ".mmt0-weak-part-count",
                                  text: "5箇所に筋力低下があります。"
    expect(page).to have_selector ".mmt6-weak-part-count",
                                  text: "6箇所に筋力低下があります。"
  end

  scenario "edit patient mmt" do
    visit patient_mmt_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_mmt_scale_path(
      second_patient, second_patient_mmt
    )
    expect(page).to have_selector ".page-title", text: "MMT編集"
    select "5", from: "mmt_scale[right_shoulder_flexion]"
    select "4", from: "mmt_scale[right_hip_adduction]"
    select "2", from: "mmt_scale[left_ankle_extension]"
    click_on "保存する"
    expect(page).to have_current_path patient_mmt_scales_path second_patient
    expect(page).to have_selector ".mmt0-weak-part-count",
                                  text: "1箇所に筋力低下があります。"
    click_on "詳細"
    expect(page).to have_selector ".right_shoulder_flexion_score", text: "5"
    expect(page).to have_selector ".right_hip_adduction_score", text: "4"
    expect(page).to have_selector ".left_ankle_extension_score", text: "2"
  end

  scenario "destory patient mmt", js: true do
    visit patient_mmt_scales_path second_patient
    expect(page).to have_selector ".mmt0-weak-part-count",
                                  text: "3箇所に筋力低下があります。"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).not_to have_selector ".mmt0-limit-part-count",
                                      text: "3箇所に筋力低下があります。"
  end

  scenario "show patient page part of mmt" do
    visit patient_path second_patient
    expect(page).to have_selector ".mmt-weak-part-count", text: "筋力低下: 3箇所"
    expect(page).to have_selector ".mmt-weak-part",
                                  text: "右肩関節屈曲 右股関節内転 右足関節底屈"
  end
end
