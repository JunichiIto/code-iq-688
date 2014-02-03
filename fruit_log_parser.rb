class FruitLogParser
  class RegexCounter
    GROUP_ENCLOSURES = %w|() {} []|.map(&:chars).freeze

    def self.count(str)
      group_finders
        .map{|finder| str.scan(finder) }.flatten
        .map{|group| group.scan(/\w+/).count }.max
    end

    def self.group_finders
      patterns.map{|ptn| Regexp.new(ptn, Regexp::EXTENDED) }
    end

    def self.patterns
      GROUP_ENCLOSURES.map{|enclosure| pattern(*enclosure) }
    end

    # /(?<grouped>\((?:\g<grouped>|[^\(\)])*\))/
    def self.pattern(left, right)
      <<-"PTN"
        (?<grouped>
          \\#{left}
            (?:
              \\g<grouped> | [^\\#{left}\\#{right}]
            )*
          \\#{right}
        )
      PTN
    end
  end

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    RegexCounter.count(text)
  end
end