require 'spec_helper'
require 'time'

describe Register do
  before(:all) do
    @access = ApacheLogAnalizer.new File.dirname(__FILE__) + "/resources/access.log"    
  end  

  it 'should contain the date of access' do
    @access = ApacheLogAnalizer.new File.dirname(__FILE__) + "/resources/access.log"
    @access[0].date.should == Time.new(2012, "Mar", 22, 11, 12, 35)
  end
end
