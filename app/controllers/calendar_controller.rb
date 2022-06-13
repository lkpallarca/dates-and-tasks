class CalendarController < ApplicationController
  def index
    @categories = Category.where(user_id: current_user.id) if user_signed_in?
  end
end
