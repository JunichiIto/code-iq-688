class FruitLogParser
  BRACKET_PAIRS = %w![] {} ()!.map(&:chars).freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    BRACKET_PAIRS.map{|pairs| count_max(text, *pairs) }.max
  end

  def self.count_max(text, left, right, stack = [])
    text.chars.each_with_object([]).each_with_index {|(char, counts), index|
      stack << index if char == left
      counts << text[stack.pop..index].scan(/\w+/).size if char == right && stack.any?
    }.max || 0
  end
end