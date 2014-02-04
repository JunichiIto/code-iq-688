class FruitLogParser
  GROUP_ENCLOSURES = %w|() {} []|.map(&:chars).freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits(line) }
  end

  def self.count_fruits(text)
    GROUP_ENCLOSURES
      .map{|encl| encl.map{|s| "\\#{s}" } }
      .map{|left, right| /#{left}(?:\g<0>|[^#{left}#{right}])*#{right}/ }
      .map{|r| text.scan(r) }.flatten
      .map{|s| s.scan(/\w+/).count }
      .max
  end
end