class CalendarController < ApplicationController
  def show
    @categories = current_user.categories
  end
end
