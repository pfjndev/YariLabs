module Chess
  RANKS = 1..8
  FILES = "A".."H"

  def self.valid_square?(rank, file)
    RANKS.include?(rank.to_i) && FILES.include?(file.upcase)
  end

  def self.nick_name(first_name, last_name)
    ("" << first_name[0,2] << last_name[-2..]).upcase
    
  end

  def self.move_message(first_name, last_name, square)
    nickname = nick_name(first_name, last_name)
    
    success = "#{nickname} moved to #{square}"
    error = "#{nickname} attempted to move to #{square}, but that is not a valid square"
    
    valid_square?(square[1], square[0]) ? success : error
  end
end