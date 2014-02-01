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
      @start_char = brackets[0]
      @end_char = brackets[-1]
    end

    def count_max(text)
      list_counts(text).max || 0
    end

    private

    def list_counts(text)
      text.scan(regex).map{|s| s.scan(/\w+/).size }
    end

    def regex
      Regexp.new(pattern)
    end

    def pattern
      "\\#{@start_char}[^\\#{@end_char}]+\\#{@end_char}"
    end
  end
end