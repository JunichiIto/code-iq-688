class FruitLogParser
  GROUP_ENCLOSURES = %w|() {} []|.map(&:chars).freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    count_fruits = ->(s){ s.scan(/\w+/).count }
    count_max = ->(r){ text.scan(r).flatten.map(&count_fruits).max || 0 }
    GROUP_ENCLOSURES
      .map{|enclosure| pattern(*enclosure) }
      .map{|ptn| Regexp.new(ptn, Regexp::EXTENDED) }
      .map(&count_max)
      .max
  end

  # E.g. \((?:\g<0>|[^\(\)])*\)
  def self.pattern(left, right)
    <<-"PTN"
      \\#{left}
        (?:
          \\g<0> | [^\\#{left}\\#{right}]
        )*
      \\#{right}
    PTN
  end
end