require 'rails_helper'

RSpec.feature "TendonReflexScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:third_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_tendon_reflex) do
    create(:tendon_reflex_scale, jaw: "absent",
                                 abdominal: "slightly_exaggerated",
                                 right_pectoral: "markedly_exaggerated",
                                 patient: second_patient)
  end
  let!(:oldest_third_patient_tendon_reflex) do
    create(:tendon_reflex_scale, left_pectoral: "absent",
                                 right_biceps: "absent",
                                 left_biceps: "slightly_exaggerated",
                                 right_triceps: "moderately_exaggerated",
                                 left_triceps: "moderately_exaggerated",
                                 patient: third_patient)
  end
  let!(:thrid_patient_tendon_reflex) do
    create_list(:tendon_reflex_scale, 5, right_brachioradialis: "moderately_exaggerated",
                                         patient: third_patient)
  end
  let!(:latest_third_patient_tendon_reflex) do
    create(:tendon_reflex_scale, left_brachioradialis: "slightly_exaggerated",
                                 right_pronator: "markedly_exaggerated",
                                 left_pronator: "absent",
                                 patient: third_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient tendon reflex" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "深部腱反射"
    expect(page).not_to have_selector ".defined-scale", text: "深部腱反射"
    click_on "腱反射"
    expect(page).to have_current_path new_patient_tendon_reflex_scale_path(
      first_patient
    )
    expect(page).to have_selector ".page-title", text: "深部腱反射作成"
    select "(++)", from: "tendon_reflex_scale[right_pectoral]"
    select "(+++)", from: "tendon_reflex_scale[left_triceps]"
    select "(-)", from: "tendon_reflex_scale[left_achilles_tendon]"
    click_on "保存する"
    expect(page).to have_current_path patient_tendon_reflex_scales_path(first_patient)
    expect(page).to have_selector ".tendon_reflex0-hyperreflexia-part", text: "2箇所"
    expect(page).to have_selector ".tendon_reflex0-hyporeflexia-part", text: "1箇所"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "新規作成"
    expect(page).to have_link "詳細"
    expect(page).to have_link "編集"
    expect(page).to have_link "削除"
  end

  scenario "show patient tendon reflex" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "深部腱反射"
    expect(page).not_to have_selector ".undefined-scale", text: "深部腱反射"
    click_on "深部腱反射"
    expect(page).to have_current_path patient_tendon_reflex_scales_path second_patient
    click_on "詳細"
    expect(page).to have_current_path patient_tendon_reflex_scale_path(
      second_patient, second_patient_tendon_reflex
    )
    expect(page).to have_selector ".page-title", text: "深部腱反射"
    expect(page).to have_selector ".hyperreflexia-detail",
                                  text: "腹筋反射 右胸筋反射"
    expect(page).to have_selector ".jaw_score", text: "(-)"
    expect(page).to have_selector ".abdominal_score", text: "(++)"
    expect(page).to have_selector ".right_pectoral_score", text: "(++++)"
    expect(page).to have_link "腱反射一覧"
    expect(page).to have_link "腱反射を編集"
    expect(page).to have_link "腱反射を削除"
  end

  scenario "index patient tendon_reflex" do
    visit patient_tendon_reflex_scales_path third_patient
    expect(page).to have_selector ".page-title", text: "深部腱反射一覧"
    expect(page).to have_selector ".tendon_reflex0-hyperreflexia-part",
                                  text: "2箇所"
    expect(page).to have_selector ".tendon_reflex0-hyporeflexia-part",
                                  text: "1箇所"
    expect(page).to have_selector ".tendon_reflex6-hyperreflexia-part",
                                  text: "3箇所"
    expect(page).to have_selector ".tendon_reflex6-hyporeflexia-part",
                                  text: "2箇所"
  end

  scenario "edit patient tendon reflex" do
    visit patient_tendon_reflex_scales_path second_patient
    click_on "編集"
    expect(page).to have_current_path edit_patient_tendon_reflex_scale_path(
      second_patient, second_patient_tendon_reflex
    )
    expect(page).to have_selector ".page-title", text: "深部腱反射編集"
    select "(+++)", from: "tendon_reflex_scale[jaw]"
    select "(++)", from: "tendon_reflex_scale[abdominal]"
    select "(-)", from: "tendon_reflex_scale[right_pectoral]"
    click_on "保存する"
    expect(page).to have_current_path patient_tendon_reflex_scales_path second_patient
    click_on "詳細"
    expect(page).to have_selector ".jaw_score", text: "(+++)"
    expect(page).to have_selector ".abdominal_score", text: "(++)"
    expect(page).to have_selector ".right_pectoral_score", text: "(-)"
  end

  scenario "destory patient tendon reflex", js: true do
    visit patient_tendon_reflex_scales_path second_patient
    expect(page).to have_selector ".tendon_reflex0-hyperreflexia-part",
                                  text: "2箇所"
    expect(page).to have_selector ".tendon_reflex0-hyporeflexia-part",
                                  text: "1箇所"
    page.accept_confirm do
      click_on "削除"
    end
    expect(page).to have_current_path patient_tendon_reflex_scales_path(
      second_patient
    )
    expect(page).not_to have_selector ".tendon_reflex0-hyperreflexia-part",
                                      text: "2箇所"
    expect(page).not_to have_selector ".tendon_reflex0-hyporeflexia-part",
                                      text: "1箇所"
  end

  scenario "show patient page part of tendon reflex" do
    visit patient_path second_patient
    expect(page).to have_selector ".tendon-reflex-hyperreflexia-part-count", text: "腱反射亢進: 2箇所"
    expect(page).to have_selector ".tendon-reflex-hyporeflexia-part-count", text: "腱反射低下: 1箇所"
    expect(page).to have_selector ".tendon-reflex-hyperreflexia-part", text: ""
    expect(page).to have_selector ".tendon-reflex-hyporeflexia-part", text: ""
  end
end
