require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LineSchedule do

  before do
    @valid_attributes = {
      :time => Time.now,
      :line_number => 19,
      :direction => 'krematorium',
      :stop_name => 'rynek wieluński',
      :arrival_time => Time.now,
      :shedule_type => 'working days'
      
    }
    end

  it "should create a new instance given valid attributes" do
    LineSchedule.create!(@valid_attributes)
  end

  it 'should be invalid when ' do
  end

end
 