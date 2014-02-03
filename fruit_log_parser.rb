class FruitLogParser
  GROUP_ENCLOSURES = %w|() {} []|.map(&:chars).freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits(line) }
  end

  def self.count_fruits(text)
    count_words = ->(s){ s.scan(/\w+/).count }
    count_max = ->(r){ text.scan(r).flatten.map(&count_words).max || 0 }
    regexp = ->(encl) { Regexp.new(pattern(*encl), Regexp::EXTENDED) }

    GROUP_ENCLOSURES.map(&regexp).map(&count_max).max
  end

  def self.pattern(l, r)
    <<-PTN
      \\#{l}
        (?:
          \\g<0> | [^\\#{l}\\#{r}]
        )*
      \\#{r}
    PTN
  end
end