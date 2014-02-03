class FruitLogParser
  TARGET_BRACKETS = %w![] {} ()!.freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    TARGET_BRACKETS.map{|pair| max_fruits_count(text, *pair.chars) }.max
  end

  def self.max_fruits_count(text, left, right, stack: [])
    text.chars.each_with_object([]).each_with_index {|(char, counts), index|
      stack << index if char == left
      counts << text[stack.pop..index].scan(/\w+/).size if char == right && stack.any?
    }.max || 0
  end
end