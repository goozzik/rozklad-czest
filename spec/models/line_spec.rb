require 'spec_helper'

describe Line do
  before(:each) do
    @valid_attributes = {
      :number => "value for number",
      :direction => "value for direction",
      :stations => 
    }
  end

  it "should create a new instance given valid attributes" do
    Line.create!(@valid_attributes)
  end
end
