class TwoFer
  def self.two_fer(*name)
    if name.empty?
      "One for you, one for me."
    else
      "One for #{name.first.to_s}, one for me."
    end
  end
end