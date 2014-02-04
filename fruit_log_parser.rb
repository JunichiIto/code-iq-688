class FruitLogParser
  GROUP_ENCLOSURES = %w|() {} []|.map(&:chars).freeze

  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits(line) }
  end

  def self.count_fruits(text)
    count_words = ->(s){ s.scan(/\w+/).count }
    escape = ->(encl){ encl.map{|s| "\\#{s}" } }
    regexp = ->((left, right)){ /#{left}(?:\g<0>|[^#{left}#{right}])*#{right}/ }
    count_max = ->(r){ text.scan(r).flatten.map(&count_words).max || 0 }

    GROUP_ENCLOSURES.map(&escape).map(&regexp).map(&count_max).max
  end
end