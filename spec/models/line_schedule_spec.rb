# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LineSchedule do

  let(:the_class) { LineSchedule }

  let(:valid_attributes) { {
    :line_number => 19,
    :direction => 'krematorium',
    :stop_name => 'rynek wieluński',
    :arrival_time => Time.now,
    :shedule_type => 'working days'
  } }

  it "should create a new instance given valid attributes" do
    the_class.create!(valid_attributes)
  end

  it 'should be invalid when ' do
  end

end
 
