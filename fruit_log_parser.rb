class FruitLogParser
  TARGET_BRACKETS = %w![] {} ()!.freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    TARGET_BRACKETS.map{|pair| list_counts(text, pair) }.flatten.compact.max
  end

  def self.list_counts(text, bracket_pair)
    start_end_table(text, bracket_pair).map {|s, e|
      text[s..e].scan(/\w+/).size unless e.nil?
    }
  end

  def self.start_end_table(text, bracket_pair)
    left, right = bracket_pair.chars
    text.chars.each_with_object({}).each_with_index do |(char, table), index|
      if char == left
        table[index] = nil
      end
      if char == right && start_index = table.invert[nil]
        table[start_index] = index
      end
    end
  end
end