require 'spec_helper'

describe Line do

  let(:the_class) { Line }

  let(:valid_attributes)  {{
    :number => "value for number",
    :direction => "value for direction",
    :stations => []
  } }

  it "should create a new instance given valid attributes" do
    Line.create!(valid_attributes)
  end

  describe ".ids_by_stations" do
    let(:id1) { mock }
    let(:id2) { mock }
    let(:the_object1) { mock(:id => id1) }
    let(:the_object2) { mock(:id => id2) }
    before do
      the_class.stub!(:find).with(
        :all, :conditions => ["stations LIKE ?", "%station1%station2%"], :select => 'id'
      ).and_return([the_object1, the_object2])
    end

    describe "behavior" do
      after { the_class.ids_by_stations("station1", "station2") }

      it "should call .find proper way" do
        the_class.should_receive(:find).with(
          :all, :conditions => ["stations LIKE ?", "%station1%station2%"], :select => 'id'
        ).and_return([])
      end
    end

    describe "returns" do
      subject { the_class.ids_by_stations("station1", "station2") }

      it { should == [ id1, id2 ] }
    end

    context "when no stations given" do
      describe "behavior" do
        after { the_class.ids_by_stations() }

        it "should not call .find" do
          the_class.should_not_receive(:find)
        end
      end

      describe "returns" do
        subject { the_class.ids_by_stations() }

        it { should == [] }
      end
    end
  end

end
