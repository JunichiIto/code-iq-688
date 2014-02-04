class FruitLogParser
  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits(line) }
  end

  def self.count_fruits(text)
    %w|() {} []|
      .map(&:chars)
      .map{|encl| encl.map{|s| "\\#{s}" } }
      .map{|left, right| /#{left}(?:\g<0>|[^#{left}#{right}])*#{right}/ }
      .map{|r| text.scan(r) }.flatten
      .map{|s| s.scan(/\w+/).count }
      .max
  end
end