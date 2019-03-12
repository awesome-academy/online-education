class ShopsController < ApplicationController
  def index
    @courses = Course.page(params[:page]).per Settings.limit
  end
end
