class FruitLogParser
  TARGET_BRACKETS = %w![] {} ()!.freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    TARGET_BRACKETS.map{|pair| count_max(text, pair) }.max
  end

  def self.count_max(text, bracket_pair)
    start_end_table(text, bracket_pair).map {|s, e|
      e ? text[s..e].scan(/\w+/).size : 0
    }.max || 0
  end

  def self.start_end_table(text, bracket_pair)
    left, right = bracket_pair.chars
    text.each_char_with_table_and_index do |(char, table), index|
      if char == left
        table[index] = nil
      end
      if char == right && start_index = table.invert[nil]
        table[start_index] = index
      end
    end
  end

  class ::String
    def each_char_with_table_and_index(&block)
      self.chars.each_with_object({}).each_with_index &block
    end
  end
end