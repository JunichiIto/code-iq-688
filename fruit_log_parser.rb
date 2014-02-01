class FruitLogParser
  BRACKET_PAIRS = %w!() {} []!.freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits(line) }
  end

  def self.count_fruits(text)
    fruits_counters.map{|counter| counter.count_max(text) }.max
  end

  def self.fruits_counters
    BRACKET_PAIRS.map{|pair| FruitsCounter.new(pair) }
  end

  class FruitsCounter
    def initialize(bracket_pair)
      left, right = bracket_pair.chars
      @regexp = Regexp.new("\\#{left}[^\\#{right}]+\\#{right}")
    end

    def count_max(text)
      text.scan(@regexp).map{|s| s.scan(/\w+/).size }.max || 0
    end
  end
end