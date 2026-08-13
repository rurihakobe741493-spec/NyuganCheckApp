# app/helpers/qa_helper.rb
module QaHelper
  def qa_item_path(id)
    item = QaItem.find(id)
    raise "未定義のQ&A項目: #{id}" if item.nil? && Rails.env.local?
    return qa_path if item.nil?

    qa_path(category: item.category, open: item.id, anchor: item.id)
  end
end