class FruitLogParser
  GROUP_ENCLOSURES = %w|() {} []|.map(&:chars).freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    group_finders.map{|finder| count_max(text, finder) }.max
  end

  def self.count_max(str, finder)
    str.scan(finder).flatten.map{|s| s.scan(/\w+/).count }.max || 0
  end

  def self.group_finders
    patterns.map{|ptn| Regexp.new(ptn, Regexp::EXTENDED) }
  end

  def self.patterns
    GROUP_ENCLOSURES.map{|enclosure| pattern(*enclosure) }
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