require 'apachelogregex'

class ApacheLogAnalizer < Array 
  attr_accessor :log

  def initialize(log_file)
    formato = '%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"'
    parser = ApacheLogRegex.new(formato)
    log = File.open(log_file).readlines.map { |linha| parser.parse(linha) }.compact
    log.each do |register|
      self.push Register.new register
    end
  end

  def registers_of_day(date)
    self.find_all {|register| register.date.to_date == date.to_date}
  end

  def registers_before_of_date(date)
    self.find_all {|register| register.date.to_date < date.to_date}
  end

  def registers_after_of_date(date)
     self.find_all {|register| register.date.to_date > date.to_date}
  end
end

