require 'rails_helper'

RSpec.feature "hdsrScales", type: :feature do
  let!(:therapist) { create(:therapist) }
  let!(:first_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient) { create(:patient, therapist: therapist) }
  let!(:second_patient_first_hdsr_scale) do
    create(:hdsr_scale, age: 1,
                        year: 1,
                        month: 1,
                        patient: second_patient)
  end
  let!(:second_patient_hdsr_scales) do
    create_list(:hdsr_scale, 5, day: 1,
                                day_of_the_week: 1,
                                first_three_word: 1,
                                second_three_word: 1,
                                third_three_word: 1,
                                patient: second_patient)
  end
  let!(:second_patient_latest_hdsr_scale) do
    create(:hdsr_scale, place: 2,
                        memory_first_word: 2,
                        memory_second_word: 2,
                        memory_third_word: 2,
                        five_goods: 5,
                        vegetables: 5,
                        patient: second_patient)
  end

  before do
    sign_in therapist
  end

  scenario "create a patient hdsr" do
    visit patient_path first_patient
    expect(page).to have_selector ".undefined-scale", text: "HDS-R"
    expect(page).not_to have_selector ".defined-scale", text: "HDS-R"
    click_on "HDS-R"
    expect(page).to have_current_path new_patient_hdsr_scale_path(first_patient)
    expect(page).to have_content first_patient.unique_id
    find("input[name='hdsr_scale[age]'][value='1']").set(true)
    find("input[name='hdsr_scale[year]'][value='1']").set(true)
    find("input[name='hdsr_scale[month]'][value='1']").set(true)
    click_on "保存する"
    expect(page).to have_current_path patient_hdsr_scales_path(first_patient)
    expect(page).to have_selector ".hdsr0_total_score", text: "3"
    expect(page).to have_link "患者ページに戻る"
    expect(page).to have_link "編集する"
    expect(page).to have_link "削除する"
    click_on "患者ページに戻る"
    expect(page).to have_current_path patient_path(first_patient)
    expect(page).to have_selector ".defined-scale", text: "HDS-R"
    expect(page).not_to have_selector ".undefined-scale", text: "HDS-R"
  end

  scenario "patient hdsr index page" do
    visit patient_path second_patient
    expect(page).to have_selector ".defined-scale", text: "HDS-R"
    expect(page).not_to have_selector ".undefined-scale", text: "HDS-R"
    click_on "HDS-R"
    expect(page).to have_current_path patient_hdsr_scales_path(second_patient)
    expect(all(".hdsr_score").size).to eq(7)
    expect(all(".edit_link").size).to eq(7)
    expect(all(".delete_link").size).to eq(7)
    expect(page).to have_selector ".hdsr0_total_score", text: "18"
    expect(page).to have_selector ".hdsr6_total_score", text: "3"
  end

  scenario "edit patient hdsr" do
    visit patient_hdsr_scales_path second_patient
    find(".hdsr0_edit_link").click
    expect(page).to have_current_path edit_patient_hdsr_scale_path(
      second_patient, second_patient_latest_hdsr_scale
    )
    find("input[name='hdsr_scale[place]'][value='1']").set(true)
    find("input[name='hdsr_scale[memory_first_word]'][value='1']").set(true)
    find("input[name='hdsr_scale[memory_second_word]'][value='1']").set(true)
    find("input[name='hdsr_scale[memory_third_word]'][value='1']").set(true)
    find("input[name='hdsr_scale[five_goods]'][value='1']").set(true)
    find("input[name='hdsr_scale[vegetables]'][value='1']").set(true)
    click_on "保存する"
    expect(page).to have_current_path patient_hdsr_scales_path(second_patient)
    expect(page).to have_selector ".hdsr0_total_score", text: "6"
  end

  scenario "destory patient hdsr", js: true do
    visit patient_hdsr_scales_path second_patient
    page.accept_confirm do
      find(".hdsr0_delete_link").click
    end
    expect(page).to have_current_path patient_hdsr_scales_path second_patient
    expect(all(".hdsr_score").size).to eq(6)
    expect(page).to have_selector ".hdsr0_total_score", text: "5"
  end
end
