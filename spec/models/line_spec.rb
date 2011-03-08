require 'spec_helper'

describe Line do

  let(:valid_attributes)  {{
    :number => "value for number",
    :direction => "value for direction",
    :stations => []
  } }

  it "should create a new instance given valid attributes" do
    Line.create!(valid_attributes)
  end

end
