class FruitLogParser
  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    %w!{} [] ()!.map{|pair| count_max(text, pair) }.max
  end

  def self.count_max(text, bracket_pair)
    start_end_table(text, bracket_pair).map {|s, e|
      e ? text[s..e].scan(/\w+/).size : 0
    }.max || 0
  end

  def self.start_end_table(text, bracket_pair)
    left, right = bracket_pair.chars
    text.chars.each_with_object({}).each_with_index do |(c, table), index|
      if c == left
        table[index] = nil
      end
      if c == right && key = table.invert[nil]
        table[key] = index
      end
    end
  end
end