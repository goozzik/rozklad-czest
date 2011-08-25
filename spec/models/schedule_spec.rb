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
    the_class.create!(valid_attributes)
  end

  describe ".today" do
    let(:now) { Date.new(2011, 3, 15).to_time.at_beginning_of_day }
    let(:lines_id) { mock }
    let(:station_from_id) { mock }
    before do
      Time.stub!(:now => now)
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
          AND ((sunday = 't' AND saturday = 't' AND work = 't' AND holiday = 't')
          OR (sunday = ? AND saturday = ? AND work = ? AND holiday = ?)
          OR (sunday = ? AND saturday = ? AND work = 'f' AND holiday = 'f'))",
          lines_id,
          station_from_id,
          now,
          false,
          false,
          true,
          false,
          false,
          false
        ],
        :order => 'arrival_at',
        :limit => 10
      )
    end
  end

  describe ".tomorrow" do
    let(:now) { Date.new(2011, 3, 15).to_time.at_beginning_of_day }
    let(:tomorrow) { now.tomorrow }
    let(:lines_id) { mock }
    let(:station_from_id) { mock }
    let(:limit) { mock }
    before do
      Time.stub!(:now => now)
      the_class.stub!(
        :lines_id => lines_id,
        :station_from_id => station_from_id,
        :limit => limit
      )
    end
    after { the_class.tomorrow(lines_id, station_from_id, limit) }

    it "should call find proper way" do
      the_class.should_receive(:find).with(
        :all,
        :conditions => [
        "line_id IN (?)
          AND station_id = ?
          AND arrival_at > ?
          AND ((sunday = 't' AND saturday = 't' AND work = 't' AND holiday = 't')
          OR (sunday = ? AND saturday = ? AND work = ? AND holiday = ?)
          OR (sunday = ? AND saturday = ? AND work = 'f' AND holiday = 'f'))",
          lines_id,
          station_from_id,
          tomorrow,
          false,
          false,
          true,
          false,
          false,
          false
        ],
        :order => 'arrival_at',
        :limit => limit
      )
    end
  end

  describe ".get" do
    let(:station_from_id) { mock }
    let(:station_to_id) { mock }
    let(:today_schedules) { [] }
    let(:next_day_schedules) { [] }
    let(:left) { 10 }
    let(:station_to) { mock }
    before do
      Line.stub!(:ids_by_stations).with(station_from_id, station_to_id).and_return(lines_id)
      the_class.stub!(:today).with(lines_id, station_from_id).and_return(today_schedules)
      the_class.stub!(:tomorrow).with(lines_id, station_from_id, left).and_return(next_day_schedules)
      Station.stub!(:find).with(station_to_id).and_return(station_to)
    end

    context "when no connection between stations" do
      let(:lines_id) { [] }

      describe "returns" do
        subject { the_class.get(station_from_id, station_to_id) }

        it { should == { :schedules => [], :station_to => station_to } }
      end
    end

    context "when there are connections between stations" do
      let(:lines_id) { [ mock ] }

      context "and today schedules contain 10 records" do
        let(:today_schedules) { [ mock, mock, mock, mock, mock, mock, mock, mock, mock, mock ] }
        let(:left) { 0 }

        describe "behavior" do
          after { the_class.get(station_from_id, station_to_id) }

          it "should call Line.ids_by_stations proper way" do
            Line.should_receive(:ids_by_stations).with(station_from_id, station_to_id).and_return(lines_id)
          end

          it "should call .today proper way" do
            the_class.should_receive(:today).with(lines_id, station_from_id).and_return(today_schedules)
          end

          it "should not call .tomorrow" do
            the_class.should_not_receive(:tomorrow)
          end
        end

        describe "returns" do
          subject { the_class.get(station_from_id, station_to_id) }

          it { should == { :schedules => today_schedules, :station_to => station_to } }
        end
      end

      context "and today schedules contain 5 records" do
        let(:today_schedules) { [ mock, mock, mock, mock, mock ] }
        let(:left) { 5 }

        describe "behavior" do
          after { the_class.get(station_from_id, station_to_id) }

          it "should call Line.ids_by_stations proper way" do
            Line.should_receive(:ids_by_stations).with(station_from_id, station_to_id).and_return(lines_id)
          end

          it "should call .today proper way" do
            the_class.should_receive(:today).with(lines_id, station_from_id).and_return(today_schedules)
          end

          it "should call .tomorrow proper way" do
            the_class.should_receive(:tomorrow).with(lines_id, station_from_id, left).and_return(next_day_schedules)
          end
        end


        context "and next day schedules contain 5 records" do
          let(:next_day_schedules) { [ mock, mock, mock, mock, mock ] }

          describe "returns" do
            subject { the_class.get(station_from_id, station_to_id) }

            it { should == { :schedules => today_schedules + next_day_schedules, :station_to => station_to } }
          end
        end

        context "and next day schedules contain no records" do
          let(:next_day_schedules) { [] }

          describe "returns" do
            subject { the_class.get(station_from_id, station_to_id) }

            it { should == { :schedules => today_schedules, :station_to => station_to } }
          end
        end
      end

      context "and today schedules contain no records" do
        let(:today_schedules) { [] }
        let(:left) { 10 }

        describe "behavior" do
          after { the_class.get(station_from_id, station_to_id) }

          it "should call Line.ids_by_stations proper way" do
            Line.should_receive(:ids_by_stations).with(station_from_id, station_to_id).and_return(lines_id)
          end

          it "should call .today proper way" do
            the_class.should_receive(:today).with(lines_id, station_from_id).and_return(today_schedules)
          end

          it "should call .tomorrow proper way" do
            the_class.should_receive(:tomorrow).with(lines_id, station_from_id, left).and_return(next_day_schedules)
          end
        end

        context "and next day schedules contain 10 records" do
          let(:next_day_schedules) { [ mock, mock, mock, mock, mock, mock, mock, mock, mock, mock ] }

          describe "returns" do
            subject { the_class.get(station_from_id, station_to_id) }

            it { should == { :schedules => next_day_schedules, :station_to => station_to } }
          end
        end

        context "and next day schedules contain no records" do
          let(:next_day_schedules) { [] }

          describe "returns" do
            subject { the_class.get(station_from_id, station_to_id) }

            it { should == { :schedules => [], :station_to => station_to } }
          end
        end
      end
    end
  end

  describe ".get_by_near_stations_and_station_to" do
    let(:station1) { Station.create(:name => 'ZANA', :lat => 1, :lng => 1) }
    let(:station2) { Station.create(:name => 'MALOWNICZA', :lat => 2, :lng => 2) }
    let(:station_to) { Station.create(:name => 'BULOWA', :lat => 3, :lng => 3) }
    let(:within) { mock }
    let(:float_within) { mock }
    let(:location) { mock }
    let(:stations_within) { [station2, station1] }
    let(:stations_within_ordered) { [station1, station2] }
    let(:station1_id) { station1.id }
    let(:station_to_id ) { station_to.id }
    let(:line_with_connection_with_station1) { mock }
    let(:schedules_with_station1) { mock }
    let(:station2_id) { station2.id }
    let(:line_with_connection_with_station2) { nil }
    let(:schedules_with_station2) { [] }
    before do
      Station.stub!(:to_f).with(within).and_return(float_within)
      Station.stub!(:within).with(float_within, :origin => location).and_return(stations_within)
      stations_within.stub!(:order).with('distance asc').and_return(stations_within_ordered)
      Line.stub!(:find_first_by_stations).with(station1_id, station_to_id).and_return(line_with_connection_with_station1)
      the_class.stub!(:get).with(station1_id, station_to_id).and_return(schedules_with_station1)
      Line.stub!(:find_first_by_stations).with(station2_id, station_to_id).and_return(line_with_connection_with_station2)
      the_class.stub!(:get).with(station2_id, station_to_id).and_return(schedules_with_station2)
    end
    subject { the_class.get_by_near_stations_and_station_to(within, location, station_to_id) }

    it { should == [schedules_with_station1] }
  end

  describe ".get_by_station_from_and_location" do
    let(:station1) { Station.create(:name => 'ZANA', :lat => 1, :lng => 1) }
    let(:station2) { Station.create(:name => 'MALOWNICZA', :lat => 2, :lng => 2) }
    let(:station_from) { Station.create(:name => 'BULOWA', :lat => 3, :lng => 3) }
    let(:location) { mock }
    let(:location_latlng) { mock }
    let(:stations_within) { [station2, station1] }
    let(:stations_within_ordered) { [station1, station2] }
    let(:station_from_id) { station_from.id }
    let(:station1_id) { station1.id }
    let(:line_with_connection_with_station1) { mock }
    let(:schedules_with_station1) { mock }
    let(:station2_id) { station2.id }
    let(:line_with_connection_with_station2) { nil }
    let(:schedules_with_station2) { [] }
    before do
      Schedule.stub!(:location_to_latlng).with(location).and_return(location_latlng)
      Station.stub!(:within).with(0.5, :origin => location_latlng).and_return(stations_within)
      stations_within.stub!(:order).with('distance asc').and_return(stations_within_ordered)
      Line.stub!(:find_first_by_stations).with(station_from_id, station1_id).and_return(line_with_connection_with_station1)
      the_class.stub!(:get).with(station_from_id, station1_id).and_return(schedules_with_station1)
      Line.stub!(:find_first_by_stations).with(station_from_id, station2_id).and_return(line_with_connection_with_station2)
      the_class.stub!(:get).with(station_from_id, station2_id).and_return(schedules_with_station2)
    end
    subject { the_class.get_by_station_from_and_location(station_from_id, location) }

    it { should == [schedules_with_station1] }
  end

  describe ".location_to_latlng" do
    context "when location passed have ','" do
      describe "returns" do
        subject { the_class.location_to_latlng("Blachownia, Mickiewicza") }

        it { should == [50.77296, 18.97876] }
      end
    end

    context "when location passed not have ','" do
      describe "returns" do
        subject { the_class.location_to_latlng("Mickiewicza 16") }

        it { should == [50.8012568, 19.1137475] }
      end
    end
  end

end
