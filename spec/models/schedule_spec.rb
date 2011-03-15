require 'spec_helper'

describe Schedule do

  should_belong_to :line
  should_belong_to :station

  let(:valid_station_attributes) { {
    :name => "value for name",
    :lat => 1,
    :lng => 1,
  } }

  let(:valid_attributes) { {
    :line => Line.create,
    :station => Station.create(valid_station_attributes),
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
