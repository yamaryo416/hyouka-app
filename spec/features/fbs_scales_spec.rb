require 'rails_helper'

RSpec.feature "FbsScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_fbs) do
    create(:fbs_scale, stand_up: "poor",
                       standing: "trace",
                       sitting: "fair",
                       patient: second_patient)
  end
  let!(:oldest_third_patient_fbs) do
    create(:fbs_scale, sit_down: "poor",
                       transfer: "fair",
                       standing_with_eyes_close: "good",
                       standing_with_leg_close: "good",
                       reach_forward: "good",
                       patient: third_patient)
  end
  let!(:thrid_patient_fbs) do
    create_list(:fbs_scale, 5, pickup_from_floor: "poor", patient: third_patient)
  end
  let!(:latest_third_patient_fbs) do
    create(:fbs_scale, turn_around: "poor",
                       one_rotation: "poor",
                       stepup_and_down: "fair",
                       tandem_standing: "good",
                       patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient fbs" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "FBS"
    expect(page).not_to have_selector ".defined-scale", text: "FBS"
    click_on "FBS"
    expect(page).to have_current_path new_patient_fbs_scale_path(first_patient)
    expect(page).to have_selector ".page-title", text: "FBS作成"
    select "1:一人で座れるが、しゃがみこみを制御できない",
           from: "fbs_scale[sit_down]"
    select "4:ほとんど手を用いずに安全に移乗が可能である",
           from: "fbs_scale[transfer]"
    select "2:3秒間の閉眼立位保持が可能である",
           from: "fbs_scale[standing_with_eyes_close]"
    click_on "保存する"
    expect(page).to have_current_path patient_fbs_scales_path(first_patient)
    expect(page).to have_selector ".fbs0-total-score", text: "7点"
    expect(page).to have_selector ".fbs0-undefined-count",
                                  text: "11項目が未入力です。"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient fbs" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "FBS"
    expect(page).not_to have_selector ".undefined-scale", text: "FBS"
    click_on "FBS"
    expect(page).to have_current_path patient_fbs_scales_path second_patient
    click_on "詳細"
    expect(page).to have_current_path patient_fbs_scale_path(
      second_patient, second_patient_fbs
    )
    expect(page).to have_selector ".page-title", text: "FBS"
    expect(page).to have_selector ".stand_up_score",
                                  text: "2:数回の施行後、手を使用して立ち上がりが可能である"
    expect(page).to have_selector ".standing_score",
                                  text: "1:数回の施行にて30秒間の立位保持が可能である"
    expect(page).to have_selector ".sitting_score",
                                  text: "3:監視下での2分間の座位保持が可能である"
    expect(page).to have_link "FBS一覧"
    expect(page).to have_link "FBSを編集"
    expect(page).to have_link "FBSを削除"
  end

  scenario "index patient fbs" do
    visit patient_fbs_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "FBS一覧"
    expect(page).to have_selector ".fbs0-total-score", text: "11点"
    expect(page).to have_selector ".fbs0-undefined-count",
                                  text: "10項目が未入力です。"
    expect(page).to have_selector ".fbs6-total-score", text: "17点"
    expect(page).to have_selector ".fbs6-undefined-count",
                                  text: "9項目が未入力です。"
  end

  scenario "edit patient fbs" do
    visit patient_fbs_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_fbs_scale_path(
      second_patient, second_patient_fbs
    )
    expect(page).to have_selector ".page-title", text: "FBS編集"
    select "4:立ち上がりが可能である",
           from: "fbs_scale[stand_up]"
    select "4:安全に2分間の立位保持が可能である",
           from: "fbs_scale[standing]"
    select "4:安全に2分間の座位保持が可能である",
           from: "fbs_scale[sitting]"
    click_on "保存する"
    expect(page).to have_current_path patient_fbs_scales_path second_patient
    click_on "詳細"
    expect(page).to have_selector ".stand_up", text: "椅子からの立ち上がり"
    expect(page).to have_selector ".stand_up_score",
                                  text: "4:立ち上がりが可能である"
    expect(page).to have_selector ".standing", text: "立位保持"
    expect(page).to have_selector ".standing_score",
                                  text: "4:安全に2分間の立位保持が可能である"
    expect(page).to have_selector ".sitting", text: "座位保持(寄りかからずに座る)"
    expect(page).to have_selector ".sitting_score",
                                  text: "4:安全に2分間の座位保持が可能である"
    expect(page).to have_selector ".fbs-total-score", text: "12点"
  end

  scenario "destory patient fbs", js: true do
    visit patient_fbs_scales_path second_patient
    expect(page).to have_selector ".fbs0-total-score", text: "6点"
    expect(page).to have_selector ".fbs0-undefined-count",
                                  text: "11項目が未入力です。"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).to have_current_path patient_fbs_scales_path second_patient
    expect(page).not_to have_selector ".fbs0-total-score", text: "6点"
    expect(page).not_to have_selector ".fbs0-undefined-count",
                                      text: "11項目が未入力です。"
  end

  scenario "show patient page part of fbs" do
    visit patient_path second_patient
    expect(page).to have_selector ".fbs-total-score", text: "合計　6点"
    expect(page).to have_selector ".fbs-undefined-columns-count", text: "*11項目が未入力です。"
  end
end
