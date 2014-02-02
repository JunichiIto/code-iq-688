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

    def count_fruits(text)
      start_index = nil
      parenthesis_count = 0
      memo = [0]
      text.chars.each_with_index do |c, i|
        # off => onになったらstart_indexを保存
        if start_index == nil && c == @left
          start_index = i
          parenthesis_count = 1
        elsif start_index != nil
          # onかつ(が見つかったらカウントアップ
          parenthesis_count += 1 if c == @left
          # onかつ)が見つかったらカウントダウン
          parenthesis_count -= 1 if c == @right
          # onかつカウントが0になったらstart_indexから現在地までのフルーツを数える
          if parenthesis_count == 0
            memo << text[start_index..i].scan(/\w+/).size
            start_index = nil
          end
        end
      end
      memo.max
    end
  end
end