class MentorsController < ApplicationController
  before_filter :authenticate_user!, :check_user_mentor

  def index
    @users = current_user.review_users.order(:last_name)
    @outstanding = current_user.hours_to_confirm
    @processed = current_user.hours_processed
    @no_hours = current_user.users_no_hours
  end

  def show
    user = params[:id]
    @user = user_hours_review(user)
  end

private

  def user_hours_review(user)
    return unless user
    current_user.review_users.find(user)
  end

end
