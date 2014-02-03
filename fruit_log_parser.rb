class FruitLogParser
  class RegexCounter
    GROUP_ENCLOSURE = %w|() {} []|.freeze

    def self.count(str)
      group_finders
        .map {|finder|str.scan(finder) }.flatten
        .map {|group| group.split(separator).reject(&:empty?) }
        .map(&:size).max
    end

    def self.group_finders
      GROUP_ENCLOSURE.map {|enclosure|
        Regexp.new(pattern(enclosure), Regexp::EXTENDED)
      }
    end

    # /(?<grouped>\((?:\g<grouped>|[^\(\)])*\))/
    def self.pattern(enclosure)
      left, right = enclosure.split(//)
      <<"PTN"
      (?<grouped>
        \\#{left}
          (?:
            \\g<grouped> | [^\\#{left}\\#{right}]
          )*
        \\#{right}
      )
PTN
    end

    def self.separator
      Regexp.new("[#{Regexp.escape(GROUP_ENCLOSURE.join)}\s]")
    end
  end

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    RegexCounter.count(text)
  end
end