require 'spec_helper'

describe Schedule do

  let(:valid_attributes) { {
    :line => Line.create,
    :station => Station.create,
    :arrival_at => '',
    :work => false,
    :saturday => false,
    :sunday => false,
    :holiday => false
  } }

  it "should create a new instance given valid attributes" do
    Schedule.create!(valid_attributes)
  end

end
