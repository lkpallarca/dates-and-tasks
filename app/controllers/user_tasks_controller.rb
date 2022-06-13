class UserTasksController < ApplicationController
  def new
    @query = User.ransack(params[:q])
    @users = @query.result(distinct: true)
  end
end
