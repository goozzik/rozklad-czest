require 'spec_helper'

describe Schedule do

  let(:the_class) { Schedule }

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

  describe ".today" do
    let(:now) { Date.new(2011, 3, 15).to_time.at_beginning_of_day }
    let(:lines_id) { mock }
    let(:station_from_id) { mock }
    let(:one_hour_from_now) { now.advance(:hours => 1) }
    before do
      Time.stub!(:now => now)
      now.stub!(:andvance).with(:hours => 1).and_return(one_hour_from_now)
      the_class.stub!(
        :lines_id => lines_id,
        :station_from_id => station_from_id
      )
    end
    after { the_class.today(lines_id, station_from_id) }

    it "should call find proper way" do
      the_class.should_receive(:find).with(
        :all,
        :conditions => [
        "line_id IN (?)
          AND station_id = ?
          AND arrival_at > ?
          AND sunday = ?
          AND saturday = ?
          AND work = ?",
          lines_id,
          station_from_id,
          one_hour_from_now,
          false,
          false,
          true
        ],
        :order => 'arrival_at',
        :limit => 10
      )
    end
  end

end
