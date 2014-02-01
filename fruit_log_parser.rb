class FruitLogParser
  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    %w!() {} []!
      .map{|brackets| BracketsParser.new(brackets).count_fruits(text) }
      .flatten.max
  end

  class BracketsParser
    def initialize(brackets)
      @start_char = brackets[0]
      @end_char = brackets[-1]
    end

    def count_fruits(text)
      text.scan(regex).map{|s| s.scan(/\w+/).size }
    end

    private

    def regex
      Regexp.new "\\#{@start_char}[^\\#{@end_char}]+\\#{@end_char}"
    end
  end
end