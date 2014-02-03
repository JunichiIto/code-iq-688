class FruitLogParser
  GROUP_ENCLOSURES = %w|() {} []|.map(&:chars).freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits(line) }
  end

  def self.count_fruits(text)
    count_words = ->(s){ s.scan(/\w+/).count }

    GROUP_ENCLOSURES
      .map{|encl| regexp(*encl) }
      .map{|r| text.scan(r).flatten.map(&count_words).max || 0 }
      .max
  end

  # E.g. \((?:\g<0>|[^\(\)])*\)
  def self.regexp(left, right)
    Regexp.new(<<-PTN, Regexp::EXTENDED)
      \\#{left}
        (?:
          \\g<0> | [^\\#{left}\\#{right}]
        )*
      \\#{right}
    PTN
  end
end