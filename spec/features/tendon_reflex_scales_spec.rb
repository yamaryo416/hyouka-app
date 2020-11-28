require 'rails_helper'

RSpec.feature "TendonReflexScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_tendon_reflex) do
    create(:tendon_reflex_scale, jaw: "diminished",
                                 abdominal: "slightly_exaggerated",
                                 right_pectoral: "markedly_exaggerated",
                                 patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create patient tendon　reflex" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "深部腱反射"
    expect(page).not_to have_selector ".defined-scale", text: "深部腱反射"
    click_on "深部腱反射"
    expect(page).to have_current_path new_patient_tendon_reflex_scales_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    select "(++)", from: "tendon_reflex_scale[right_pectoral]"
    select "(±)", from: "tendon_reflex_scale[left_triceps]"
    select "(-)", from: "tendon_reflex_scale[left_achilles_tendon]"
    click_on "保存する"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "深部腱反射"
    expect(page).not_to have_selector ".undefined-scale", text: "深部腱反射"
    click_on "深部腱反射"
    expect(page).to have_current_path patient_tendon_reflex_scales_path(first_patient)
    expect(page).to have_selector ".right_pectoral_score", text: "(++)"
    expect(page).to have_selector ".left_triceps_score", text: "(±)"
    expect(page).to have_selector ".left_achilles_tendon_score", text: "(-)"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "深部腱反射を編集する"
    expect(page).to have_link "深部腱反射を削除する"
  end

  scenario "edit patient tendon reflex" do
    visit patient_tendon_reflex_scales_path second_patient
    click_on "深部腱反射を編集する"
    expect(page).to have_current_path edit_patient_tendon_reflex_scales_path second_patient
    select "(+++)", from: "tendon_reflex_scale[jaw]"
    select "(++)", from: "tendon_reflex_scale[abdominal]"
    select "(-)", from: "tendon_reflex_scale[right_pectoral]"
    click_on "保存する"
    expect(page).to have_current_path patient_tendon_reflex_scales_path second_patient
    expect(page).to have_selector ".jaw_score", text: "(+++)"
    expect(page).to have_selector ".abdominal_score", text: "(++)"
    expect(page).to have_selector ".right_pectoral_score", text: "(-)"
  end

  scenario "destory patient tendon reflex", js: true do
    visit patient_tendon_reflex_scales_path second_patient
    page.accept_confirm do
      click_on "深部腱反射を削除する"
    end
    expect(page).to have_current_path patient_path second_patient
    expect(page).to have_selector ".undefined-scale", text: "深部腱反射"
    expect(page).not_to have_selector ".defined-scale", text: "深部腱反射"
  end
end
