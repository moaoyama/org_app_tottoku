module DocumentsHelper
  def document_decision_badge(decision)
    case decision
    when "紙で保管が必要"
      image = image_tag('icons/important.svg', alt: '紙で保管が必要', class: 'badge-icon') +
      content_tag(:span, '紙で保管が必要', class: 'badge badge-important')
    when "データ保管でOK"
      image = image_tag('icons/folder.svg', alt: 'データ保管でOK', class: 'badge-icon') +
      content_tag(:span, 'データ保管でOK', class: 'badge badge-folder')
    when "処分してOK"
      image = image_tag('icons/trash.svg', alt: '処分してOK', class: 'badge-icon') +
      content_tag(:span, '処分してOK', class: 'badge badge-trash')
    else
      content_tag(:span, '判定不能', class: 'badge badge-unknown')
    end

    content_tag(:div, image, class: 'decision-result')
  end
end