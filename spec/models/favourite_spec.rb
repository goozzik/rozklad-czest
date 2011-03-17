# coding: utf-8
require 'spec_helper'

describe Favourite do

  let(:the_class) { Favourite }
  let(:the_object) { the_class.new }

  describe "#upcase_stations" do
    before do
      the_object.station_from = "station from"
      the_object.station_to = "station to"
      the_object.send(:upcase_stations)
    end
    subject { the_object }

    its(:station_from) { should == "STATION FROM" }
    its(:station_to) { should == "STATION TO" }
  end

  describe "#set_on_start_page_value" do
    before do
      the_object.on_start_page = "1"
    end
    after { the_object.send(:set_on_start_page_value) }
    subject { the_object }

    its(:on_start_page) { should == true }
  end

  describe "#validate_station_from_exist" do
    let(:errors) { mock(:add => nil) }
    let(:station_from) { mock }
    before do 
      the_object.stub!(
        :errors => errors,
        :station_from => station_from
      )
      Station.stub!(:find_by_name).with(station_from).and_return(validate_station_from_exist)
    end
    after { the_object.send(:validate_station_from_exist) }

    context "when station_from not exist" do
      let(:validate_station_from_exist) { false }

      it "should add error to station_from" do
        errors.should_receive(:add).with(:station_from, 'Przystanek odjazdowy nie istnieje.')
      end
    end

    context "when station_from exist" do
      let(:validate_station_from_exist) { true }

      it "should not add error to station_from" do
        errors.should_not_receive(:add)
      end
    end
  end

  describe "#validate_station_to_exist" do
    let(:errors) { mock(:add => nil) }
    let(:station_to) { mock }
    before do 
      the_object.stub!(
        :errors => errors,
        :station_to => station_to
      )  
      Station.stub!(:find_by_name).with(station_to).and_return(validate_station_to_exist)
    end
    after { the_object.send(:validate_station_to_exist) }

    context "when station_to not exist" do
      let(:validate_station_to_exist) { false }

      it "should add error to station_to" do
        errors.should_receive(:add).with(:station_to, 'Przystanek docelowy nie istnieje.')
      end
    end

    context "when station_to exist" do
      let(:validate_station_to_exist) { true }

      it "should not add error to station_to" do
        errors.should_not_receive(:add)
      end
    end
  end

  describe "#validate_line_exist" do
    let(:errors) { mock(:add => nil) }
    let(:station_to_id) { mock }
    let(:station_from_id) { mock }
    let(:station_to_object) { mock(:id => station_to_id) }
    let(:station_from_object) { mock(:id => station_from_id) }
    before do 
      the_object.stub!(
        :errors => errors,
        :station_to_object => station_to_object,
        :station_from_object => station_from_object
      )
      Line.stub!(:find_first_by_stations).with([station_from_object.id, station_to_object.id]).and_return(validate_line_exist)
    end
    after { the_object.send(:validate_line_exist) }

    context "when line not exist" do
      let(:validate_line_exist) { false }

      it "should add error to station_from" do
        errors.should_receive(:add).with(:station_from, 'Brak połączeń.')
      end
    end

    context "when line exist" do
      let(:validate_line_exist) { true }

      it "should not add error to station_from" do
        errors.should_not_receive(:add)
      end
    end
  end

end
