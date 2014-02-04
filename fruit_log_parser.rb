class FruitLogParser
  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits(line) }
  end

  def self.count_fruits(text)
    %|(){}[]|.chars
      .map{|s| "\\#{s}" }.each_slice(2)
      .map{|left, right| /#{left}(?:\g<0>|[^#{left}#{right}])*#{right}/ }
      .map{|r| text.scan(r) }.flatten
      .map{|s| s.scan(/\w+/).count }
      .max
  end
end