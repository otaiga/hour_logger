require 'spec_helper'

describe UserHoursController do

  describe "with valid login" do
    before(:each) do
      sign_in given_user
    end

    it "should get index" do
      get :index
      assigns(:user_hours).should == given_user.user_hours
      response.should be_success
    end

    it "should create user hours and new placement" do
      post :create, {user_hours: {hours: 1.5, date_occurred: Date.today}, placement: {name: "some_name", area: "some_area"}}
      flash[:notice].should == "hours have been logged"
      given_user.user_hours.count.should == 1
      Placement.count.should == 1
      given_user.user_hours.first.placement.should == Placement.first
      response.should redirect_to user_hours_path
    end

    it "should create user hours and placement should be existing" do
      post :create, {user_hours: {hours: 1.5, date_occurred: Date.today}, placement: {name: given_placement.name, area: given_placement.area}}
      flash[:notice].should == "hours have been logged"
      given_user.user_hours.count.should == 1
      Placement.count.should == 1
      given_user.user_hours.first.placement.should == Placement.first
      response.should redirect_to user_hours_path
    end

    it "should create user hours and new placement if new name" do
      post :create, {user_hours: {hours: 1.5, date_occurred: Date.today}, placement: {name: "new_name", area: given_placement.area}}
      flash[:notice].should == "hours have been logged"
      given_user.user_hours.count.should == 1
      Placement.count.should == 2
      given_user.user_hours.first.placement.should == Placement.last
      response.should redirect_to user_hours_path
    end

    it "should get new view" do
      get :new
      response.should be_success
    end

    it "should be able to destroy a user_hour" do
      @user_hour = given_user.user_hours.create!(hours: 1.5, date_occurred: Date.today, placement_id: given_placement.id)
      delete :destroy, :id => @user_hour.id
      response.should redirect_to user_hours_path
      given_user.user_hours.count.should == 0
    end
  end

  describe "without valid login" do

    it "should be re-directed to login page on index" do
      get :index
      response.should redirect_to new_user_session_path
    end

    it "should be re-directed to login page on create" do
      post :create, {user_hours: {hours: 1.5, date_occurred: Date.today}, placement: {name: given_placement.name, area: given_placement.area}}
      response.should redirect_to new_user_session_path
    end

    it "should be re-directed to login page on destroy" do
      @user_hour = given_user.user_hours.create!(hours: 1.5, date_occurred: Date.today, placement_id: given_placement.id)
      delete :destroy, :id => @user_hour.id
      response.should redirect_to new_user_session_path
    end

  end

end
