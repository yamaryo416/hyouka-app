require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  let!(:patient) { create(:patient) }
  let!(:sias) { create(:sias_scale, patient: patient) }

  it "provide flash message" do
    expect(flash_message("ログインしました。", :success)).to eq(
      "<div class=\"alert alert-success\">"\
      "<button class=\"close\" data-dismiss=\"alert\">x</button>ログインしました。</div>"
    )
  end

  it "provide index scale link section" do
    expect(index_scale_link_section("sias_scales", patient)).to eq(
      "<div class=\"link-section d-flex justify-content-between\">"\
      "<div class=\"left_link\">"\
      "<a class=\"custom-btn btn-radius-solid\" href=\"/patients/#{patient.id}\">患者ページに戻る</a>"\
      "</div>"\
      "<div class=\"right_link\">"\
      "<a class=\"btn btn-primary\" href=\"/patients/#{patient.id}/sias_scales/new\">新規作成</a>"\
      "</div>"\
      "</div>"
    )
  end

  it "provide show scale link section" do
    expect(show_scale_link_section("SIAS", "sias_scales", patient, sias)).to eq(
      "<div class=\"link-section d-flex justify-content-between\">"\
      "<div class=\"left_link\">"\
      "<a class=\"custom-btn btn-radius-solid\" href=\"/patients/#{patient.id}/sias_scales\">SIAS一覧に戻る</a>"\
      "</div>"\
      "<div class=\"right_link\">"\
      "<a class=\"custom-btn btn-radius-solid\" href=\"/patients/#{patient.id}/sias_scales/#{sias.id}/edit\">SIASを編集する</a>"\
      "<a class=\"custom-btn btn-radius-solid\" href=\"/patients/#{patient.id}/sias_scales/#{sias.id}\" data-method=\"delete\" data-confirm=\"SIASを削除します。よろしいですか?\">SIASを削除する</a>"\
      "</div>"\
      "</div>"
    )
  end

  it "provide show scale link section" do
    expect(form_scale_link_section("SIAS", "sias_scales", patient)).to eq(
      "<div class=\"link-section\">"\
      "<a class=\"custom-btn btn-radius-solid\" href=\"/patients/#{patient.id}/sias_scales\">SIAS一覧に戻る</a>"\
      "</div>"
    )
  end
end
