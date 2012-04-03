require 'spec_helper'

describe ApacheLogAnalizer do
  it 'it get all access from log' do
    access = ApacheLogAnalizer.new File.dirname(__FILE__) + "/resources/access.log"
    access.length.should == 8
  end

  it 'it should get all registers of a particular date' do
    access = ApacheLogAnalizer.new File.dirname(__FILE__) + "/resources/access.log"
    access_of_day = access.registers_of_day Time.new 2012, "Mar", 22
    access_of_day.length.should == 3
  end
end