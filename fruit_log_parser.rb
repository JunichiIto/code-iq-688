class FruitLogParser
  TARGET_BRACKETS = %w![] {} ()!.freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    TARGET_BRACKETS.map{|pair| list_counts(text, pair) }.flatten.compact.max
  end

  def self.list_counts(text, bracket_pair)
    create_ranges(text, bracket_pair).map {|range|
      text[range].scan(/\w+/).size
    }
  end

  def self.create_ranges(text, bracket_pair)
    left, right, stack = *bracket_pair.chars, []
    text.chars.each_with_object([]).each_with_index {|(char, ranges), index|
      stack << index if char == left
      ranges << (stack.pop..index) if char == right && stack.any?
    }
  end
end