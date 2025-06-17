class AssemblyLine
  def initialize(speed)
    @speed = speed
  end

  def production_rate_per_hour
    case @speed
      when 1..4
        success_rate = 1.0
      when 5..8
        success_rate = 0.9
      when 9
        success_rate = 0.8
      when 10
        success_rate = 0.77
      else
        success_rate = 0.0
    end
        
    success_rate * (@speed * 221.0)
  end
  
  def working_items_per_minute
    (production_rate_per_hour / 60).to_i
  end
end