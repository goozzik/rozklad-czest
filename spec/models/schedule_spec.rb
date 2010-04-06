require 'spec_helper'

describe Schedule do
  before(:each) do
    @valid_attributes = {
      :line => ,
      :station => ,
      :arrival_at => Time.now,
      :work => false,
      :saturday => false,
      :sunday => false,
      :holiday => false
    }
  end

  it "should create a new instance given valid attributes" do
    Schedule.create!(@valid_attributes)
  end
end
