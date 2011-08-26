require 'spec_helper'

describe User do

  let(:the_class) { User }
  let(:the_object) { the_class.new }

  describe "#start_page_favourites" do
    let(:favourites_on_start_page) { mock("favourites_on_start_page") }
    let(:favourites) { mock("favourites") }
    before do
      the_object.stub!(:favourites => favourites)
      favourites.stub!(:on_start_page => favourites_on_start_page)
    end

    describe "behavior" do
      after { the_object.start_page_favourites }

      it "should call #favourites" do
        the_object.should_receive(:favourites).and_return(favourites)
      end

      it "should get feavourites for start page" do
        favourites.should_receive(:on_start_page)
      end
    end

    describe "returns" do
      subject { the_object.start_page_favourites }

      it { should == favourites_on_start_page }
    end
  end

end
