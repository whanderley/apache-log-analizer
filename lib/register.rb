require 'time'

class Register  
  attr_accessor :date, :user_agent, :host

  def initialize(register)
    @date = get_date_of register
    @user_agent = register["%{User-Agent}i"]
    @host = register["%h"]
  end

  def get_date_of(register)
    date = register['%t']
    day, mounth, year = date[1,11].split '/'
    hour, minute, second = date[13,8].split ':'
    Time.new year, mounth, day, hour, minute, second.to_i #to_i necessary because of a bug on time
  end
end
