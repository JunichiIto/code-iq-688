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

    # ({}apple) melon strawberry(melon(apple apple) (melon strawberry apple) melon
    def count_fruits(text, root: true)
      start_indexes = []
      end_indexes = []
      counting = false
      start_index = nil
      parenthesis_count = 0
      memo = [0]
      inner_start_indexes = []
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
            inner_start_indexes << i
          end
          if c == @right
            end_indexes[-1] = i
            parenthesis_count -= 1
          end
          if parenthesis_count.zero?
            memo << text[start_index..i].scan(/\w+/).size
            start_index = nil
          end
        end
      end
      start_indexes.zip(end_indexes) do |s, e|
        if e != nil
          memo << text[s..e].scan(/\w+/).size
        end
      end
      memo.max
      ## カッコがきれいにとじていなければ、内側にちゃんと閉じているカッコがなかったか再検索する
      #if root && start_index != nil
      #  inner_start_indexes.each do |start_index|
      #    memo << count_fruits(text[start_index..-1], root: false)
      #  end
      #end
      #memo.max
    end
  end
end