require 'spec_helper'

describe Station::Import do

  let(:the_class) { Station::Import }

  describe ".get_id_by_name_if_exist" do
    let(:name) { mock }
    before { the_class.stub!(:find_by_name).with(name).and_return(station) }
    subject { the_class.get_id_by_name_if_exist(name) }

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
