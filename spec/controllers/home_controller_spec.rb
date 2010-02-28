require 'spec_helper'

describe HomeController do

  it 'should respond to index' do
    get :index
    response.should be_success
    response.should render_template(:index)
  end

end
