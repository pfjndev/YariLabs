# Example: make_acronym("Portable Network Graphics") => "PNG"
def make_acronym(input)
  # Validate input type
  return 'Not a string' unless input.is_a?(String)
  
  # Validate input contains only letters and spaces
  return 'Not letters' unless input.match?(/\A[ A-Za-z]*\z/)
  
  # Handle empty string case
  return input unless not input.empty?

  # Create acronym from first letters of each word
  input.strip
       .split(' ')
       .reject(&:empty?) # Same as { |word| !word.empty? }
       .map { |word| word[0].upcase }
       .join
end