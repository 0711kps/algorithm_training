Index = Struct.new(:left, :right)

def min_win(string, pattern)
  return 'no such window' if pattern.length > string.length

  @string = string.freeze
  @pattern = pattern.freeze
  @index = Index.new(0, 0)
  @min_len = string.length
  @min_window = ''
  @target_hash = pattern.chars.each_with_object({}) { _2[_1] = (_2[_1] || 0) + 1 }.freeze
  @comparable_hash = @target_hash.keys.each_with_object({}) { _2[_1] = 0 }
  move_right
  return 'no such window' unless @min_window.length.positive?

  @min_window
end

def move_right
  while @index.right < @string.length
    next_char = @string[@index.right]
    @index.right += 1
    @comparable_hash[next_char] += 1 if @pattern.include?(next_char)
    if @target_hash.keys.all? { @comparable_hash[_1] >= @target_hash[_1] }
      new_len = @index.right - @index.left + 1
      @min_len = [@min_len, new_len].min
      @min_window = @string[@index.left..@index.right]
      move_left
    end
  end
end

def move_left
  loop do
    next_char = @string[@index.left]
    @index.left += 1
    if @pattern.include?(next_char)
      @comparable_hash[next_char] -= 1
      break
    end
  end
end

puts min_win('happy new year', 'rh')
