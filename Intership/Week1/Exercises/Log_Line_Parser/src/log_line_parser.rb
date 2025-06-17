class LogLineParser
  def initialize(line)
    @line = line
  end

  def message
    @line.gsub(/\[.*?\]:/, '').strip
  end

  def log_level
    @line.match(/\[([A-Z]+)\]/)[1].downcase
  end

  def reformat
    msg = @line.match(/:\s(.+)$/)[1]
    "#{msg.strip} (#{log_level})"
  end
end