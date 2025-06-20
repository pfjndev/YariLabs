=begin
Write your code for the 'Acronym' exercise in this file. Make the tests in
`acronym_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/acronym` directory.
=end


class Acronym
  
  def self.abbreviate(input)
    # Validate input type
    return 'Not a string' unless input.is_a?(String)
    
    # Hyphens are word separators (like white-space), all other punctuation can be removed.
    #return 'Not letters' unless input.match?(/\A[ A-Za-z]*\z/)
    
    # Handle empty string case
    return input unless not input.empty?
  
    # Create acronym from first letters of each word
    # Split on both spaces and hyphens, then filter out empty strings and non-alphabetic words
    input.split(/[\s\-]+/)
         .reject(&:empty?)
         .select { |word| word.match?(/[A-Za-z]/) }
         .map { |word| word[0].upcase }
         .join
  end
end