require 'spec_helper'

describe Station do

  should_have_many :schedules

  before(:each) do
    @valid_attributes = {
      :name => "value for name"
    }
  end

  it "should create a new instance given valid attributes" do
    Station.create!(@valid_attributes)
  end

  describe ".get_id_by_name_if_exist" do
    let(:name) { mock }
    before { Station.stub!(:find_by_name).with(name).and_return(station) }
    subject { Station.get_id_by_name_if_exist(name) }

    context "when exist with give name" do
      let(:station_id) { mock }
      let(:station) { mock(:id => station_id) }

      it { should == station_id }
    end

    context "when not exist with given name" do
      let(:station) { nil }

      it { should be_nil }
    end
  end

end
