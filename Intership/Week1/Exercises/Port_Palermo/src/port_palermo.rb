module Port
  IDENTIFIER = :PALE
  def self.get_identifier(city)
    city[0,4].upcase.to_sym
  end

  def self.get_terminal(ship_identifier)
    terminal = {
      'OIL' => :A,
      'GAS' => :A
    }
    return terminal[ship_identifier[0,3]] || :B
  end
end