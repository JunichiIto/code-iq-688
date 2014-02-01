class FruitLogParser
  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  def self.count_fruits(text)
    [/\{[^}]+\}/, /\[[^\]]+\]/, /\([^)]+\)/].
      map{|r| text.scan(r).map{|s| s.scan(/\w+/).size } }.
      flatten.max
  end
end