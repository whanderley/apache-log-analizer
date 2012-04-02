require 'spec_helper'

describe ApacheLogAnalizer do
  it 'it get all access from log' do
    acesso = ApacheLogAnalizer.new File.dirname(__FILE__) + "/resources/access.log"
    acesso.quantity.should == 8
  end
end
