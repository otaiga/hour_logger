require 'spec_helper'

describe Placement do
  before(:each) do
    @placement = Placement.new(name: "some_name", area: "some_area")
  end

  it "should be able to create a placement" do
    @placement.save.should == true
  end

  it "should not be able to create a placement when nil or '' " do
    placement = Placement.new(name: "", area: "")
    placement.save.should == false
  end

  it "should be able to destroy a placement" do
    @placement.destroy
    Placement.count.should == 0
  end

end
