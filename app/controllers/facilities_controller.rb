class FacilitiesController < ApplicationController
  PURPOSES = %w[guide treatment screening hboc].freeze
  DEFAULT_PURPOSE = "guide"

  def index
    @purpose = PURPOSES.include?(params[:purpose]) ? params[:purpose] : DEFAULT_PURPOSE
  end
end