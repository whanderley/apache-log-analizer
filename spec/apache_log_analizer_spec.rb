require 'spec_helper'

describe ApacheLogAnalizer do
  before(:all) do
    @access = ApacheLogAnalizer.new File.dirname(__FILE__) + "/resources/access.log"    
  end

  it 'get all access from log' do
    @access.length.should == 8
  end

  it 'should get all registers of a particular date' do
    access_of_day = @access.registers_of_day Time.new 2012, "Mar", 22
    access_of_day.length.should == 3
  end

  it 'should get all registers before of a particular date' do
    access_before_day = @access.registers_before_of_date Time.new 2012, "Mar", 26
    access_before_day.length.should == 3
  end
  
end
