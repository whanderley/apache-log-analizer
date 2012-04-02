require 'spec_helper'
require 'time'

describe Register do
  it 'should contain the date of access' do
    acesso = ApacheLogAnalizer.new File.dirname(__FILE__) + "/resources/access.log"
    register = Register.new acesso.log[0]
    register.date.should == Time.new(2012, "Mar", 22, 11, 12, 35)
  end
end
