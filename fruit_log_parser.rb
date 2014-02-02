class FruitLogParser
  BRACKET_PAIRS = %w!() {} []!.freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits(line) }
  end

  def self.count_fruits(text)
    regexps.map{|regexp| count_max(text, regexp) }.max
  end

  def self.count_max(text, regexp)
    text.scan(regexp).map{|s| s.scan(/\w+/).size }.max || 0
  end

  def self.regexps
    BRACKET_PAIRS.map{|pair| create_regexp(pair) }
  end

  def self.create_regexp(bracket_pair)
    left, right = bracket_pair.chars
    Regexp.new("\\#{left}[^\\#{right}]+\\#{right}")
  end
end