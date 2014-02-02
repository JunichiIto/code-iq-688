class FruitLogParser
  def self.parse_log(path)
    File.readlines(path).map{|line| count_fruits line }
  end

  #       {[^{}]*}
  # {[^{]*{[^{}]*}[^}]*}
  def self.count_fruits(text, count = 0, memo = [])
    pattern = "\\([^\\)}]*\\)"
    count.times do
      pattern = "\\([^\\(]*" + pattern + "[^\\)]*\\)"
    end
    r = Regexp.new pattern
    memo << text.scan(r).map{|s| s.scan(/\w+/).size }
    if text =~ r
      return count_fruits(text, count + 1, memo)
    else
      return memo.flatten.max
    end

    #[/\{[^}]+\}/, /\[[^\]]+\]/, /\([^)]+\)/].
    #  map{|r| text.scan(r).map{|s| s.scan(/\w+/).size } }.
    #  flatten.max
  end
end