require 'spec_helper'
require_relative '../src/acronym_game'

=begin 

- Implement a function called make Acronym that returns the first letters of each word in a passed in string.

- Make sure the letters returned are uppercase.

- It the value passed in is not a string return "Not a string".

- If the value passed in is a string which contains characters other than spaces and alphabet letters, return 'Not letters".

- If the string is empty, just return the string itself.

=end

RSpec.describe 'Acronym Game' do
  describe 'make_acronym' do
    context 'when the given input is a string with letters' do
      it 'returns the acronym' do
        expected_output = 'H'
        expect(make_acronym('Hello')).to eq(expected_output)
      end
    end
    context 'when the given input is a single word' do
      it 'returns the acronym' do
        expected_output = 'W'
        expect(make_acronym('World')).to eq(expected_output)
      end
    end
    context 'when the given input is a string with multiple words' do
      it 'returns the acronym' do
        expected_output = 'HC'
        expect(make_acronym('Hello Codewarrior')).to eq(expected_output)
      end
    end
    context 'when the given input is a string with multiple words and spaces' do
      it 'returns the acronym' do
        expected_output = 'HC'
        expect(make_acronym('  Hello   Codewarrior  ')).to eq(expected_output)
      end
    end

    context 'when the given input is a string with multiple words' do
      it 'returns the acronym' do
        expected_output = 'HC'
        expect(make_acronym('Hello Codewarrior')).to eq(expected_output)
      end
    end

    context 'when the given input is a string with letters' do
      it 'returns the acronym' do
        expected_output = 'HC'
        expect(make_acronym('Hello codewarrior')).to eq(expected_output)
      end
    end

    context 'when the given input is not a string' do
      it 'returns "Not a string"' do
        expect(make_acronym(42)).to eq('Not a string')
        expect(make_acronym([2, 12])).to eq('Not a string')
        expect(make_acronym({ name: 'Abraham' })).to eq('Not a string')
      end
    end

    context 'when the given input is a string with non-letter characters' do
      it 'returns "Not letters"' do
        expect(make_acronym('a42')).to eq('Not letters')
      end
    end

    context 'when the given input is an empty string' do
      it 'returns an empty string' do
        expect(make_acronym('')).to eq('')
      end
    end
  end
end
