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

    def count_fruits(text, count = 0, memo = [])
      # E.g.
      # count = 0       {[^{}]*}
      # count = 1 {[^{]*{[^{}]*}[^}]*}
      pattern = "\\#{@left}[^\\#{@right}]*\\#{@right}"
      count.times do
        pattern = "\\#{@left}[^\\#{@left}]*" + pattern + "[^\\#{@right}]*\\#{@right}"
      end
      r = Regexp.new pattern
      memo << text.scan(r).map{|s| s.scan(/\w+/).size }
      if text =~ r
        count_fruits(text, count + 1, memo)
      else
        memo.flatten.max || 0
      end
    end
  end
end