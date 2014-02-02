class FruitLogParser
  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    %w!{} [] ()!.map{|pair| count_max(text, pair) }.flatten.max
  end

  def self.count_max(text, bracket_pair)
    left, right = bracket_pair.chars
    table = {}
    text.each_char.each_with_index do |c, i|
      if c == left
        table[i] = nil
      end
      if !table.select{|k,v|v.nil?}.empty? && c == right
        key = table.invert[nil]
        table[key] = i
      end
    end
    table.map {|s, e|
      e ? text[s..e].scan(/\w+/).size : 0
    }.max || 0
  end
end