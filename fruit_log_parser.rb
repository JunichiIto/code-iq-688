class FruitLogParser
  class RegexCounter
    GROUP_ENCLOSURE = %w|() {} []|.freeze

    def self.count(str)
      group_finders
        .map{|finder| str.scan(finder) }.flatten
        .map{|group| group.scan(/\w+/).count }.max
    end

    def self.group_finders
      GROUP_ENCLOSURE.map {|enclosure|
        Regexp.new(pattern(enclosure), Regexp::EXTENDED)
      }
    end

    # /(?<grouped>\((?:\g<grouped>|[^\(\)])*\))/
    def self.pattern(enclosure)
      left, right = enclosure.chars
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
  end

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    RegexCounter.count(text)
  end
end