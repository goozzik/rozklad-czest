require 'spec_helper'

describe Line do

  let(:valid_attributes)  {{
    :number => "value for number",
    :direction => "value for direction",
    :stations => []
  } }

  let(:the_class) { Line }
  let(:the_object) { the_class.new }
  let(:valid_object) { the_class.new(valid_attributes) }

  it "should create a new instance given valid attributes" do
    the_class.create!(valid_attributes)
  end

  describe ".find_first_by_stations" do
    let(:station_from_id) { mock }
    let(:station_to_id) { mock }
    let(:lines) { mock }
    before do
      the_class.stub!(:connecting_stations_with_direction).with(station_from_id, station_to_id).and_return(lines)
      lines.stub!(:first).and_return(line)
    end

    context "when no connection between stations" do
      let(:line) { nil }

      describe "returns" do
        subject { the_class.find_first_by_stations(station_from_id, station_to_id) }

        it { should == nil }
      end
    end

    context "when there is connection between stations" do
      let(:line) { mock }

      describe "behavior" do
        after { the_class.find_first_by_stations(station_from_id, station_to_id) }

        it "should find lines with connection between stations and proper direction" do
          the_class.should_receive(:connecting_stations_with_direction).with(station_from_id, station_to_id).and_return(lines)
        end

        it "should get first line" do
          lines.should_receive(:first).and_return(line)
        end
      end

      describe "returns" do
        subject { the_class.find_first_by_stations(station_from_id, station_to_id) }

        it { should == line }
      end
    end
  end

  describe ".find_all_by_stations" do
    let(:station_from_id) { mock }
    let(:station_to_id) { mock }
    before do
      the_class.stub!(:connecting_stations_with_direction).with(station_from_id, station_to_id).and_return(lines)
    end

    context "when no connections between stations" do
      let(:lines) { [] }

      describe "returns" do
        subject { the_class.find_all_by_stations(station_from_id, station_to_id) }

        it { should == [] }
      end
    end

    context "when there are connections between stations" do
      let(:lines) { mock }

      describe "behavior" do
        after { the_class.find_all_by_stations(station_from_id, station_to_id) }

        it "should find lines with connection between stations and proper direction" do
          the_class.should_receive(:connecting_stations_with_direction).with(station_from_id, station_to_id).and_return(lines)
        end
      end

      describe "returns" do
        subject { the_class.find_all_by_stations(station_from_id, station_to_id) }

        it { should == lines }
      end
    end
  end

  describe ".ids_by_stations" do
    let(:station_from_id) { mock }
    let(:station_to_id) { mock }
    before do
      the_class.stub!(:connecting_stations_with_direction).with(station_from_id, station_to_id).and_return(lines)
      lines.stub!(:collect).with(&:id).and_return(lines_ids)
    end

    context "when no connections between stations" do
      let(:lines) { [] }
      let(:lines_ids) { [] }

      describe "returns" do
        subject { the_class.find_all_by_stations(station_from_id, station_to_id) }

        it { should == [] }
      end
    end

    context "when there are connections between stations" do
      let(:lines) { mock }
      let(:lines_ids) { mock }

      describe "behavior" do
        after { the_class.ids_by_stations(station_from_id, station_to_id) }

        it "should find lines with connection between stations and proper direction" do
          the_class.should_receive(:connecting_stations_with_direction).with(station_from_id, station_to_id).and_return(lines)
        end

        it "should collect lines ids" do
          lines.should_receive(:collect).with(&:id).and_return(lines_ids)
        end
      end

      describe "returns" do
        subject { the_class.ids_by_stations(station_from_id, station_to_id) }

        it { should == lines_ids }
      end
    end
  end

  describe ".connecting_stations_with_direction" do
    let(:station_from_id) { mock }
    let(:station_to_id) { mock }
    let(:lines_with_connection) { mock }
    before do
      the_class.stub!(:connecting_stations).with(station_from_id, station_to_id).and_return(lines_with_connection)
      lines_with_connection.stub!(:select).and_return(lines_connecting_stations_with_direction)
    end

    context "when no connections between stations" do
      let(:lines_with_connection) { [] }
      let(:lines_connecting_stations_with_direction) { [] }

      describe "returns" do
        subject { the_class.connecting_stations_with_direction(station_from_id, station_to_id) }

        it { should == [] }
      end
    end

    context "when there are connections between stations" do 
      let(:lines_with_connection) { mock }
      context "but not in proper direction" do
        let(:lines_connecting_stations_with_direction) { [] }

        describe "returns" do
          subject { the_class.connecting_stations_with_direction(station_from_id, station_to_id) }

          it { should == [] }
        end
      end

      context "in proper direction" do
        let(:lines_connecting_stations_with_direction) { mock }

        describe "behavior" do
          after { the_class.connecting_stations_with_direction(station_from_id, station_to_id) }

          it "should find lines with connection between stations" do
            the_class.should_receive(:connecting_stations).with(station_from_id, station_to_id).and_return(lines_with_connection)
          end

          it "should select lines with proper direction" do
            lines_with_connection.should_receive(:select).and_return(lines_connecting_stations_with_direction)
          end
        end

        describe "returns" do
          subject { the_class.connecting_stations_with_direction(station_to_id, station_from_id) }

          it { should == lines_connecting_stations_with_direction }
        end
      end
    end
  end

  describe ".connecting_stations" do
    let(:station_to_id) { mock }
    let(:station_object) { mock }
    let(:station_from_id) { mock }
    before do
      Station.stub!(:find).with(station_to_id).and_return(station_object)
      the_class.stub!(:with_station).with(station_from_id).and_return(lines_with_station_from)
      lines_with_station_from.stub!(:select).and_return(lines_with_connection)
    end

    context "when no lines with station from" do
      let(:lines_with_station_from) { [] }
      let(:lines_with_connection) { [] }

      describe "returns" do
        subject { the_class.connecting_stations(station_from_id, station_to_id) }

        it { should == [] }
      end
    end

    context "when there are lines with station from" do
      let(:lines_with_station_from) { mock }
      context "and no lines with station to" do
        let(:lines_with_connection) { [] }

        describe "returns" do 
          subject { the_class.connecting_stations(station_from_id, station_to_id) }

          it { should == [] }
        end
      end

      context "and with station_to" do
        let(:lines_with_connection) { mock }

        describe "behavior" do
          after { the_class.connecting_stations(station_from_id, station_to_id) }

          it "should find lines with station from" do
            the_class.should_receive(:with_station).with(station_from_id).and_return(lines_with_station_from)
          end

          it "should select lines with station to" do
            lines_with_station_from.should_receive(:select).and_return(lines_with_connection)
          end
        end

        describe "returns" do
          subject { the_class.connecting_stations(station_from_id, station_to_id) }

          it { should == lines_with_connection }
        end
      end
    end
  end

  describe ".with_station" do
    let(:the_class_with_joint_stations) { mock }
    let(:station_id) { mock }
    before do
      the_class.stub!(:joins).with(:stations).and_return(the_class_with_joint_stations)
      the_class_with_joint_stations.stub!(:all).with(:conditions => ["stations.id = ?", station_id]).and_return(lines_with_station)
    end

    context "when no lines with station" do
      let(:lines_with_station) { [] }

      describe "returns" do
        subject { the_class.with_station(station_id) }

        it { should == [] }
      end
    end

    context "when there are lines with station" do
      let(:lines_with_station) { mock }

      describe "behavior" do
        after { the_class.with_station(station_id) }

        it "should join stations" do
          the_class.should_receive(:joins).with(:stations).and_return(the_class_with_joint_stations)
        end

        it "should get all records from joint" do
          the_class_with_joint_stations.should_receive(:all).with(:conditions => ["stations.id = ?", station_id]).and_return(lines_with_station)
        end
      end

      describe "returns" do
        subject { the_class.with_station(station_id) }

        it { should == lines_with_station }
      end
    end
  end

  describe "#station_index" do
    let(:station_id) { mock }
    let(:station_object) { mock }
    before do
      Station.stub!(:find).with(station_id).and_return(station_object)
      the_object.stations.stub!(:index).with(station_object).and_return(station_index)
    end

    context "when station not belongs to line" do
      let(:station_index) { nil }

      describe "returns" do
        subject { the_object.station_index(station_id) }

        it { should == nil }
      end
    end

    context "when station belongs to line" do
      let(:station_index) { mock }

      describe "behavior" do
        after { the_object.station_index(station_id) }

        it "should get station object by id" do
          Station.should_receive(:find).with(station_id).and_return(station_object)
        end

        it "should get index by station object" do
          the_object.stations.should_receive(:index).with(station_object).and_return(station_index)
        end
      end

      describe "returns" do
        subject { the_object.station_index(station_id) }

        it { should == station_index }
      end
    end
  end

  describe ".get_numbers" do
    let(:lines) { mock }
    let(:lines_numbers) { mock }
    let(:lines_numbers_without_duplications) { mock }
    before do
      the_class.stub!(:all).and_return(lines)
      lines.stub!(:collect).with(&:number).and_return(lines_numbers)
      lines_numbers.stub!(:uniq).and_return(lines_numbers_without_duplications)
    end

    describe "behavior" do
      after { the_class.get_numbers }

      it "should get all lines" do
        the_class.should_receive(:all).and_return(lines)
      end
      
      it "should collect all lines numbers " do
        lines.should_receive(:collect).with(&:number).and_return(lines_numbers)
      end

      it "should remove duplications" do
        lines_numbers.should_receive(:uniq).and_return(lines_numbers_without_duplications)
      end
    end

    describe "returns" do
      subject { the_class.get_numbers }

      it { should == lines_numbers_without_duplications }
    end
  end

  describe "#get_map_url" do
    before { valid_object.send(:get_map_url) }
    subject { valid_object.map_url }

    it { should == "http://maps.google.com/maps/ms?msa=0&msid=214247094233741962570.0004a8f32cfdbad18e1f9&ie=UTF8&ll=50.812123,19.144642&spn=0.056322,0.057549&output=embed" }
  end
end
