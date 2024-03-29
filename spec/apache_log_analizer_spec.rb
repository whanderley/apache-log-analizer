require 'spec_helper'

describe ApacheLogAnalizer do
  before(:each) do
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
    second_date = Time.new 2012, "Mar", 25
    access_between_dates = @access.registers_between_dates first_date, second_date
    access_between_dates.length.should == 3
    first_date = Time.new 2012, "Mar", 15
    second_date = Time.new 2012, "Mar", 20
    access_between_dates = @access.registers_between_dates first_date, second_date
    access_between_dates.length.should == 0
  end

  it 'should get all registers between two hours' do
    access_between_hours = @access.registers_between_hours 11, 12
    access_between_hours.length.should == 3
    access_between_hours = @access.registers_between_hours 1, 5
    access_between_hours.length.should == 0
  end

  it 'should get all register between two hours in particular date' do
    access_between_hours_on_day_22 = @access.registers_of_day(
      Time.new 2012, 'Mar', 22).registers_between_hours 11, 12
    access_between_hours_on_day_22.length.should == 3
  end

  it 'should get all register between two hours in before date' do
    access_between_hours_before_day_23 = @access.registers_before_of_date(
      Time.new 2012, 'Mar', 23).registers_between_hours 11, 12
    access_between_hours_before_day_23.length.should == 3
        access_between_hours_before_day_20 = @access.registers_before_of_date(
      Time.new 2012, 'Mar', 20).registers_between_hours 11, 12
    access_between_hours_before_day_20.length.should == 0
  end

  it 'should get all register between two hours in after date' do
    access_between_hours_after_day_20 = @access.registers_after_of_date(
      Time.new 2012, 'Mar', 20).registers_between_hours 11, 12
    access_between_hours_after_day_20.length.should == 3
        access_between_hours_before_day_29 = @access.registers_after_of_date(
      Time.new 2012, 'Mar', 29).registers_between_hours 11, 12
    access_between_hours_before_day_29.length.should == 0
  end

  it 'should get all register of today' do
    Time.stub_chain(:new => Time.new(2012, 'Mar', 22))
    registers_today = @access.registers_today
    registers_today.length.should == 3
    access_between_hours_today = @access.registers_today.registers_between_hours 11, 12
    access_between_hours_today.length.should == 3
  end

  it 'should get all register of yesterday' do
    Time.stub_chain(:new => Time.new(2012, 'Mar', 23))
    registers_yesterday = @access.registers_yesterday
    registers_yesterday.length.should == 3
    access_between_hours_yesterday = @access.registers_yesterday.registers_between_hours 11, 12
    access_between_hours_yesterday.length.should == 3
  end

  it 'should get all register of a particular user agent' do
    @access.registers_of_agent_user('mozilla').length.should == 3
  end

  it 'should get all register of a particular host' do
    @access.registers_of_host('127.0.0.1').length.should == 3
  end

  it 'should get all register of a particular referer' do
    @access.registers_of_referer('trace').length.should == 3
  end 
end

