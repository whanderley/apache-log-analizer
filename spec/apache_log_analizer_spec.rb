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
    access_of_day = @access.registers_of_day Time.new 2012, "Mar", 18
    access_of_day.length.should == 0
  end

  it 'should get all registers before of a particular date' do
    access_before_day = @access.registers_before_of_date Time.new 2012, "Mar", 26
    access_before_day.length.should == 3
    access_of_day = @access.registers_before_of_date Time.new 2012, "Mar", 18
    access_of_day.length.should == 0
  end

  it 'should get all registers after of a particular date' do
    access_before_day = @access.registers_after_of_date Time.new 2012, "Mar", 22
    access_before_day.length.should == 5
    access_of_day = @access.registers_after_of_date Time.new 2012, "Mar", 30
    access_of_day.length.should == 0
  end

  it 'should get all registers between two dates' do
    first_date = Time.new 2012, "Mar", 21
    second_date = Time.new 2012, "Mar", 28
    access_between_dates = @access.registers_between_dates [first_date, second_date]
    access_between_dates.length.should == 8
  end

  
  
end
