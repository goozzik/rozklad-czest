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
    let(:line) { mock }
    before do
      the_class.stub!(:connecting_stations_with_direction).with(station_from_id, station_to_id).and_return(lines)
      lines.stub!(:first).and_return(line)
    end
    subject { the_class.find_first_by_stations(station_from_id, station_to_id) }

    it { should == line }
  end

  describe ".find_all_by_stations" do
    let(:station_from_id) { mock }
    let(:station_to_id) { mock }
    let(:lines) { mock }
    before do
      the_class.stub!(:connecting_stations_with_direction).with(station_from_id, station_to_id).and_return(lines)
    end

    subject { the_class.find_all_by_stations(station_from_id, station_to_id) }

    it { should == lines }
  end

  describe ".ids_by_stations" do
    let(:station_from_id) { mock }
    let(:station_to_id) { mock }
    let(:line1) { mock }
    let(:line2) { mock }
    let(:lines) { [line1, line2] }
    before do
      the_class.stub!(:connecting_stations_with_direction).with(station_from_id, station_to_id).and_return(lines)
      line1.stub!(:id).and_return(1)
      line2.stub!(:id).and_return(2)
    end

    subject { the_class.ids_by_stations(station_from_id, station_to_id) }

    it { should == [1, 2] }
  end

  describe ".connecting_stations_with_direction" do
    let(:station_from_id) { mock("station_from_id") }
    let(:station_to_id) { mock("station_to_id") }
    let(:lines_with_connection) { [line1, line2] }
    let(:line1) { mock("line1") }
    let(:line2) { mock("line2") }
    before do
      the_class.stub!(:connecting_stations).with(station_from_id, station_to_id).and_return(lines_with_connection)
      line1.stub!(:station_index).with(station_from_id).and_return(1)
      line1.stub!(:station_index).with(station_to_id).and_return(2)
      line2.stub!(:station_index).with(station_from_id).and_return(2)
      line2.stub!(:station_index).with(station_to_id).and_return(1)
    end
    subject { the_class.connecting_stations_with_direction(station_from_id, station_to_id) }

    it { should == [line1] }
  end

  describe ".connecting_stations" do
    let(:station_to_id) { mock }
    let(:station_object) { mock }
    let(:station_from_id) { mock }
    let(:lines_with_station_from) { [line1, line2] }
    let(:line1) { mock }
    let(:line2) { mock }
    let(:line1_stations) { mock }
    let(:line2_stations) { mock }
    before do
      Station.stub!(:find).with(station_to_id).and_return(station_object)
      the_class.stub!(:with_station).with(station_from_id).and_return(lines_with_station_from)
      line1.stub!(:stations).and_return(line1_stations)
      line1_stations.stub!(:include?).with(station_object).and_return(true)
      line2.stub!(:stations).and_return(line2_stations)
      line2_stations.stub!(:include?).with(station_object).and_return(false)
    end

    subject { the_class.connecting_stations(station_from_id, station_to_id) }

    it { should == [line1] }
  end

  describe ".with_station" do
    let(:the_class_with_joint_stations) { mock }
    let(:station_id) { mock }
    let(:lines_with_station) { mock }
    before do
      the_class.stub!(:joins).with(:stations).and_return(the_class_with_joint_stations)
      the_class_with_joint_stations.stub!(:all).with(:conditions => ["stations.id = ?", station_id]).and_return(lines_with_station)
    end
    subject { the_class.with_station(station_id) }

    it { should == lines_with_station }
  end

  describe "#station_index" do
    let(:station_id) { mock }
    let(:station_object) { mock }
    let(:station_index) { mock }
    before do
      Station.stub!(:find).with(station_id).and_return(station_object)
      the_object.stations.stub!(:index).with(station_object).and_return(station_index)
    end
    subject { the_object.station_index(station_id) }

    it { should == station_index }
  end

  describe ".get_numbers" do
    let(:lines) { [the_class.new(:number => "1"), the_class.new(:number => "22"), the_class.new(:number => "22")] }
    before { the_class.stub!(:all).and_return(lines) }
    subject { the_class.get_numbers }

    it { should == ["1", "22"] }
  end

  describe "#get_map_url" do
    before { valid_object.send(:get_map_url) }
    subject { valid_object.map_url }

    it { should == "http://maps.google.com/maps/ms?msa=0&msid=214247094233741962570.0004a8f32cfdbad18e1f9&ie=UTF8&ll=50.812123,19.144642&spn=0.056322,0.057549&output=embed" }
  end

end
