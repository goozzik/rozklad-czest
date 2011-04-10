require 'spec_helper'

describe Station do

  let(:the_class) { Station }
  let(:the_object) { the_class.new }

  should_have_many :schedules

  describe "uniqueness" do
    before { Station.create!(valid_attributes) }

    should_validate_uniqueness_of :name, :case_sensitive => false
  end

  context "when validate" do
    after { the_object.valid? }

    it "should call #validate_uniqueness_of_lat_lng_pair" do
      the_object.should_receive(:validate_uniqueness_of_lat_lng_pair)
    end
  end

  let(:valid_attributes) { {
    :name => "value for name",
    :lat => 1,
    :lng => 1,
  } }

  it "should create a new instance given valid attributes" do
    Station.create!(valid_attributes)
  end

  describe "#validate_uniqueness_of_lat_lng_pair" do
    let(:errors) { mock(:add => nil) }
    before do
      the_object.stub!(
        :errors => errors,
        :has_existing_lat_lng_pair? => has_existing_lat_lng_pair
      )
    end
    after { the_object.send(:validate_uniqueness_of_lat_lng_pair) }

    context "when lat-lng pair not exist" do
      let(:has_existing_lat_lng_pair) { false }

      it "should not add error to lat" do
        errors.should_not_receive(:add)
      end
    end

    context "when lat-lng pair already exist" do
      let(:has_existing_lat_lng_pair) { true }

      it "should add error to lat" do
        errors.should_receive(:add).with(:lat, 'non unique lat-lng pair')
      end
    end
  end

  describe "#has_existing_lat_lng_pair?" do
    let(:lat) { mock }
    let(:lng) { mock }
    let(:found_object) { mock(:try => nil) }
    before do
      the_class.stub!(:find_by_lat_and_lng).with(lat, lng).and_return(found_object)
      the_object.stub!(
        :lat => lat,
        :lng => lng
      )
    end
    after { the_object.send(:has_existing_lat_lng_pair?) }

    it "should find record by lat-lng pair" do
      the_class.should_receive(:find_by_lat_and_lng).with(lat, lng).and_return(found_object)
    end

    it "should try call #present? on found object" do
      found_object.should_receive(:try).with(:present?)
    end
  end

  describe ".get_ordered_letters" do
    let(:letters) { ['Z', 'M'] }
    before do
      Station.create!(:name => 'ZANA', :lat => 2, :lng => 2)
      Station.create!(:name => 'MALOWNICZA', :lat => 3, :lng => 3)
    end

    describe "returns" do
      subject { the_class.get_ordered_letters }

      it { should == letters }
    end
  end

  describe ".paginate_by_letter" do
    before do
      Station.create!(:name => 'ZANA', :lat => 2, :lng => 2)
      Station.create!(:name => 'MALOWNICZA', :lat => 3, :lng => 3)
    end

    describe "returns" do
      subject { the_class.paginate_by_letter }
      it { should == [[Station.first], [Station.last]] }
    end
  end

end
