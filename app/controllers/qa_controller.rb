class QaController < ApplicationController
  def index
    @category = QaItem.valid_category?(params[:category]) ? params[:category] : QaItem::DEFAULT_CATEGORY
    @items    = QaItem.where(category: @category)
  end
end