require 'spec_helper'
require 'time'

describe Register do
  before(:each) do
    @access = ApacheLogAnalizer.new File.dirname(__FILE__) + "/resources/access.log"    
  end  

  it 'should contain the date of access' do
    @access[0].date.should == Time.new(2012, "Mar", 22, 11, 12, 35)
  end

  it 'should contain the user agent' do
    @access[0].user_agent.should == "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.79 Safari/535.11"
  end

  it 'should contain the host' do
    @access[0].host.should == "127.0.0.1"
  end
end
