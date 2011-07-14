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
          AND sunday = ?
          AND saturday = ?
          AND work = ?
          AND holiday = ?",
          lines_id,
          station_from_id,
          now,
          false,
          false,
          true,
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
          AND sunday = ?
          AND saturday = ?
          AND work = ?
          AND holiday = ?",
          lines_id,
          station_from_id,
          tomorrow,
          false,
          false,
          true,
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
    before do
      Line.stub!(:ids_by_stations).with(station_from_id, station_to_id).and_return(lines_id)
      the_class.stub!(:today).with(lines_id, station_from_id).and_return(today_schedules)
      the_class.stub!(:tomorrow).with(lines_id, station_from_id, left).and_return(next_day_schedules)
    end

    context "when no connection between stations" do
      let(:lines_id) { [] }

      describe "returns" do
        subject { the_class.get(station_from_id, station_to_id) }

        it { should == [] }
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

          it { should == today_schedules }
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

            it { should == today_schedules + next_day_schedules }
          end
        end

        context "and next day schedules contain no records" do
          let(:next_day_schedules) { [] }

          describe "returns" do
            subject { the_class.get(station_from_id, station_to_id) }

            it { should == today_schedules }
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

            it { should == next_day_schedules }
          end
        end

        context "and next day schedules contain no records" do
          let(:next_day_schedules) { [] }

          describe "returns" do
            subject { the_class.get(station_from_id, station_to_id) }

            it { should == [] }
          end
        end
      end
    end
  end

end
