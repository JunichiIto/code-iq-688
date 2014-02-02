class FruitLogParser
  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    %w!{} [] ()!.
      map{|pair| FruitCounter.new(pair).count_fruits(text) }.
      flatten.max
  end

  class FruitCounter
    def initialize(bracket_pair)
      @left, @right = bracket_pair.chars
    end

    def count_fruits(text, root: true)
      start_indexes = []
      end_indexes = []
      start_index = nil
      parenthesis_count = 0
      text.each_char.each_with_index do |c, i|
        if start_index == nil && c == @left
          start_indexes << i
          end_indexes << nil
          start_index = i
          parenthesis_count = 1
        elsif start_index != nil
          if c == @left
            start_indexes << i
            end_indexes << nil
            parenthesis_count += 1
          end
          if c == @right
            rindex = end_indexes.rindex(nil)
            end_indexes[rindex] = i
            parenthesis_count -= 1
          end
          if parenthesis_count.zero?
            start_index = nil
          end
        end
      end
      start_indexes.zip(end_indexes).map {|s, e|
        e ? text[s..e].scan(/\w+/).size : 0
      }.max || 0
    end
  end
end