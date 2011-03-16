require 'spec_helper'

describe Station::Import do

  let(:valid_attributes) { {
    :name => 'TEATR im. A. MICKIEWICZA'
  } }

  let(:the_class) { Station::Import }
  let(:the_object) { the_class.new }
  let(:valid_object) { the_class.new(valid_attributes) }

  it "should create a new instance given valid attributes" do
    the_class.create!(valid_attributes)
  end

  context "when validating" do
    after { the_object.valid? }

    it "should call #set_lat_by_name" do
      the_object.should_receive(:set_lat_by_name)
    end

    it "should call #set_lng_by_name" do
      the_object.should_receive(:set_lng_by_name)
    end
  end

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
    let(:name) { mock }
    let(:created_record) { mock }
    before do
      the_class.stub!(:find).with(:first, :conditions => {:name => name}).and_return(record_found)
      the_class.stub!(:create!).with(:name => name).and_return(created_record)
    end

    describe "behavior" do
      after { the_class.create_if_needed!(name) }

      context "when record not found" do
        let(:record_found) { nil }

        it "should create new one" do
          the_class.should_receive(:create!).with({:name => name})
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
      subject { the_class.create_if_needed!(name) }

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

  describe "#upcase_name" do
    context "when name set" do
      before { valid_object.send(:upcase_name) }
      subject { valid_object.name }

      it { should == 'TEATR IM. A. MICKIEWICZA' }
    end

    context "when name not set" do
      before { the_object.send(:upcase_name) }
      subject { the_object.name }

      it { should be_nil }
    end
  end

  describe "#set_lat_by_name" do
    context "when name set" do
      before { valid_object.send(:set_lat_by_name) }
      subject { valid_object.lat }

      it { should == 50.815053 }
    end

    context "when name not set" do
      before { the_object.send(:set_lat_by_name) }
      subject { the_object.lat }

      it { should be_nil }
    end
  end

  describe "#set_lng_by_name" do
    context "when name set" do
      before { valid_object.send(:set_lng_by_name) }
      subject { valid_object.lng }

      it { should == 19.114172 }
    end

    context "when name not set" do
      before { the_object.send(:set_lng_by_name) }
      subject { the_object.lng }

      it { should be_nil }
    end
  end

end
