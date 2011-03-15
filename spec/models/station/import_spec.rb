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

  describe ".create_if_needed!" do
    let(:attributes) { mock }
    let(:created_record) { mock }
    before do
      the_class.stub!(:find).with(:first, :conditions => attributes).and_return(record_found)
      the_class.stub!(:create!).with(attributes).and_return(created_record)
    end

    describe "behavior" do
      after { the_class.create_if_needed!(attributes) }

      context "when record not found" do
        let(:record_found) { nil }

        it "should create new one" do
          the_class.should_receive(:create!).with(attributes)
        end
      end

      context "when record found" do
        let(:record_found) { mock }

        it "should not create new one" do
          the_class.should_not_receive(:create!)
        end
      end
    end

    describe "returns" do
      subject { the_class.create_if_needed!(attributes) }

      context "when record not found" do
        let(:record_found) { nil }

        it { should == created_record }
      end

      context "when record found" do
        let(:record_found) { mock }

        it { should be_nil }
      end
    end
  end

end
