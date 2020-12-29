module ApplicationHelper
  def flash_message(message, klass)
    content_tag(:div, class: "alert alert-#{klass}") do
      concat content_tag(:button, 'x', class: 'close',
                                       data: { dismiss: 'alert' })
      concat raw(message)
    end
  end

  # 各スケールのindexページのlink
  def index_scale_link_section(path, patient)
    content_tag(:div, class: "link-section d-flex justify-content-between") do
      concat(
        content_tag(:div, class: "left_link") do
          show_patient_link(patient)
        end
      )
      concat(
        content_tag(:div, class: "right_link") do
          new_scale_link(path, patient)
        end
      )
    end
  end

  # 各スケールのshowページのlink
  def show_scale_link_section(title, path, patient, scale)
    content_tag(:div, class: "link-section d-flex justify-content-between") do
      concat(
        content_tag(:div, class: "left_link") do
          index_scale_link(title, path, patient)
        end
      )
      concat(
        content_tag(:div, class: "right_link") do
          concat(
            edit_scale_link(title, path, patient, scale)
          )
          concat(
            delete_scale_link(title, path, patient, scale)
          )
        end
      )
    end
  end

  # 各スケールのnew, editページのlink
  def form_scale_link_section(title, path, patient)
    content_tag(:div, class: "link-section") do
      index_scale_link(title, path, patient)
    end
  end

  def show_patient_link(patient)
    content_tag(:a, class: "custom-btn btn-radius-solid",
                    href: "/patients/#{patient.id}") do
      concat "患者ページに戻る"
    end
  end

  def index_scale_link(title, path, patient)
    content_tag(:a, class: "index-link custom-btn btn-radius-solid",
                    href: "/patients/#{patient.id}/#{path}") do
      concat "#{title}一覧"
    end
  end

  def new_scale_link(path, patient)
    content_tag(:a, class: "btn btn-primary",
                    href: "/patients/#{patient.id}/#{path}/new") do
      concat "新規作成"
    end
  end

  def edit_scale_link(title, path, patient, scale)
    content_tag(:a, class: "edit-link custom-btn btn-radius-solid",
                    href: "/patients/#{patient.id}/#{path}/#{scale.id}/edit") do
      concat "#{title}を編集"
    end
  end

  def delete_scale_link(title, path, patient, scale)
    content_tag(:a, class: "delete-link custom-btn btn-radius-solid",
                    href: "/patients/#{patient.id}/#{path}/#{scale.id}",
                    data: { method: :delete, confirm: "#{title}を削除します。よろしいですか?" }) do
      concat "#{title}を削除"
    end
  end
end
