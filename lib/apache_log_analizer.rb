require 'apachelogregex'

class ApacheLogAnalizer

  attr_accessor :log
  def initialize(log_file)
    formato = '%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"'
    parser = ApacheLogRegex.new(formato)
    @log = File.open(log_file).readlines.map { |linha| parser.parse(linha) }.compact
  end

  def quantity
    @log.length
  end

end
