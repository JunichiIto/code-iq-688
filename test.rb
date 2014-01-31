class Test
  def self.hoge(text)
    [/\{[^}]+\}/, /\[[^\]]+\]/, /\([^)]+\)/].
      map{|r| text.scan(r).map{|s| s.scan(/\w+/).size } }.
      flatten.max
  end
end