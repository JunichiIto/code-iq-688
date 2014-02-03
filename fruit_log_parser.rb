class FruitLogParser
  class RegexCounter
    GROUP_ENCLOSURE = %w|() {} []|.freeze

    def self.count(str)
      group_finders = GROUP_ENCLOSURE.map do |enclosure|
        left, right = enclosure.split(//)
        Regexp.new("(?<grouped>\\#{left}(?:\\g<grouped>|[^\\#{left}\\#{right}])*\\#{right})")
        #          /(?<grouped>\((?:\g<grouped>|[^\(\)])*\))/
      end
      separator = Regexp.new("[#{Regexp.escape(GROUP_ENCLOSURE.join)} ]")
      group_finders.map { |finder| str.scan(finder) }.flatten.map { |group| group.split(separator) - [''] }.map(&:size).max
    end
  end

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    RegexCounter.count(text)
  end
end