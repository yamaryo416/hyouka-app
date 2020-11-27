require 'rails_helper'

RSpec.feature "FbsScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_fbs) do
    create(:fbs_scale, stand_up: "poor",
                       standing: "trace",
                       sitting: "fair",
                       patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient fbs" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "FBS"
    expect(page).not_to have_selector ".defined-scale", text: "FBS"
    click_on "FBS"
    expect(page).to have_current_path new_patient_fbs_scales_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    select "1:一人で座れるが、しゃがみこみを制御できない",
           from: "fbs_scale[sit_down]"
    select "4:ほとんど手を用いずに安全に移乗が可能である",
           from: "fbs_scale[transfer]"
    select "2:3秒間の閉眼立位保持が可能である",
           from: "fbs_scale[standing_with_eyes_close]"
    click_on "保存する"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".fbs-total-score", text: "7"
    expect(page).to have_selector ".undefined-columns-count",
                                  text: "11項目が未入力です。"
    expect(page).to have_selector ".defined-scale", text: "FBS"
    expect(page).not_to have_selector ".undefined-scale", text: "FBS"
    click_on "FBS"
    expect(page).to have_current_path patient_fbs_scales_path(first_patient)
    expect(page).to have_selector ".sit_down", text: "着座"
    expect(page).to have_selector ".sit_down_score",
                                  text: "1:一人で座れるが、しゃがみこみを制御できない"
    expect(page).to have_selector ".transfer", text: "移乗"
    expect(page).to have_selector ".transfer_score",
                                  text: "4:ほとんど手を用いずに安全に移乗が可能である"
    expect(page).to have_selector ".standing_with_eyes_close", text: "閉眼立位保持"
    expect(page).to have_selector ".standing_with_eyes_close_score",
                                  text: "2:3秒間の閉眼立位保持が可能である"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "FBSを編集する"
    expect(page).to have_link "FBSを削除する"
  end

  scenario "edit patient fbs" do
    visit patient_fbs_scales_path second_patient
    click_on "FBSを編集する"
    expect(page).to have_current_path edit_patient_fbs_scales_path second_patient
    select "4:立ち上がりが可能である",
           from: "fbs_scale[stand_up]"
    select "4:安全に2分間の立位保持が可能である",
           from: "fbs_scale[standing]"
    select "4:安全に2分間の座位保持が可能である",
           from: "fbs_scale[sitting]"
    click_on "保存する"
    expect(page).to have_current_path patient_fbs_scales_path second_patient
    expect(page).to have_selector ".stand_up", text: "椅子からの立ち上がり"
    expect(page).to have_selector ".stand_up_score",
                                  text: "4:立ち上がりが可能である"
    expect(page).to have_selector ".standing", text: "立位保持"
    expect(page).to have_selector ".standing_score",
                                  text: "4:安全に2分間の立位保持が可能である"
    expect(page).to have_selector ".sitting", text: "座位保持(両足を床につけ、背もたれに寄りかからずに座る)"
    expect(page).to have_selector ".sitting_score",
                                  text: "4:安全に2分間の座位保持が可能である"
    expect(page).to have_selector ".fbs-total-score", text: "12"
  end

  scenario "destory patient fbs", js: true do
    visit patient_fbs_scales_path second_patient
    page.accept_confirm do
      click_on "FBSを削除する"
    end
    expect(page).to have_current_path patient_path second_patient
    expect(page).to have_selector ".undefined-scale", text: "FBS"
    expect(page).not_to have_selector ".defined-scale", text: "FBS"
  end
end
