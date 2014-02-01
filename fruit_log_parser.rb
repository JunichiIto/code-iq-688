class FruitLogParser
  def self.count_fruits(text)
    [/\{[^}]+\}/, /\[[^\]]+\]/, /\([^)]+\)/].
      map{|r| text.scan(r).map{|s| s.scan(/\w+/).size } }.
      flatten.max
  end
end