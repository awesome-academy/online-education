class PagesController < ApplicationController
  def index
    @courses = Course.limit Settings.limit
  end
end
