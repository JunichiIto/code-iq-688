class FruitLogParser
  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    %w!() {} []!.map{|brackets|
      FruitsCounter.new(brackets).count_max(text)
    }.max
  end

  class FruitsCounter
    def initialize(brackets)
      @begin, @end = brackets.chars
    end

    def count_max(text)
      text.scan(regexp).map{|s| s.scan(/\w+/).size }.max || 0
    end

    private

    def regexp
      Regexp.new("\\#{@begin}[^\\#{@end}]+\\#{@end}")
    end
  end
end