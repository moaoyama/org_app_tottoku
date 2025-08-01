module DocumentsHelper
  def document_decision_badge(decision)
    case decision
    when "保存する"
      content_tag(:span, decision, class: "badge badge-success")
    when "保存しない"
      content_tag(:span, decision, class: "badge badge-danger")
    else
      content_tag(:span, decision, class: "badge badge-warning")
    end
  end
end

