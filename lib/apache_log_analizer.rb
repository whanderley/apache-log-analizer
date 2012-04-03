require 'apachelogregex'

class ApacheLogAnalizer < Array 
  attr_accessor :log

  def initialize(log_file)
    if log_file.class == String
      formato = '%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"'
      parser = ApacheLogRegex.new(formato)
      log = File.open(log_file).readlines.map { |linha| parser.parse(linha) }.compact
      log.each do |register|
        self.push Register.new register
      end
    else
      log_file.each do |register|
        self.push register
      end
    end
  end

  def registers_of_day(date)
    registers = self.find_all {|register| register.date.to_date == date.to_date}
    ApacheLogAnalizer.new registers
  end

  def registers_before_of_date(date)
    self.find_all {|register| register.date.to_date < date.to_date}
  end

  def registers_after_of_date(date)
    self.find_all {|register| register.date.to_date > date.to_date}
  end

  def registers_between_dates(*dates)
    self.find_all {|register| register.date.to_date >= dates.min.to_date and 
      register.date.to_date <= dates.max.to_date}
  end  

  def registers_between_hours(*hours)
    self.find_all {|register| register.date.hour >= hours.min and register.date.hour <= hours.max}
  end  
end

