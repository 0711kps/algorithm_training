class LZ77
  Pointer = Struct.new(:distance, :length, :last_char)

  def initialize(dict_size: 8, buffer_size: 4)
    @dict_size = dict_size
    @buffer_size = buffer_size
  end

  def encode(raw_string)
    # 滑動窗口(字典)
    @matched_buffer = Array.new(@dict_size)
    # 編碼緩衝區
    @encode_buffer = raw_string[0, @buffer_size].chars
    # 待編碼區
    @remain_to_encode = raw_string[@buffer_size..].chars

    encoding_process
    print_encoded
  end

  def decode(encoded)
    @matched_buffer = Array.new(@dict_size)
    @encoded = encoded
    transfer_to_pointers
    decode_process
    print_decoded
  end

  private

  def decode_process
    @result = []

    while @remain_to_decode.any?
      next_code = @remain_to_decode.shift
      decoded = if next_code.distance.zero? && next_code.length.zero?
        [next_code.last_char]
      else
        @matched_buffer[next_code.distance, next_code.length] + [next_code.last_char]
      end
      @result.push(*decoded)
      @matched_buffer.shift(next_code.length + 1)
      @matched_buffer.push(*decoded)
    end
  end

  def transfer_to_pointers
    @remain_to_decode = @encoded.split(' ').map do |encoded_string|
      if encoded_string.length == 1
        Pointer.new(0, 0, encoded_string)
      else
        encoded_array = encoded_string[1...-1].split(',')
        Pointer.new(*encoded_array[0, 2].map(&:to_i), encoded_array[2])
      end
    end
  end

  def print_decoded
    puts @result.join
  end

  def print_encoded
    formatted_array = @result.map do |pointer|
      if pointer.distance.zero? && pointer.length.zero?
        pointer.last_char
      else
        "(#{[pointer.distance, pointer.length, pointer.last_char].compact.join(',')})"
      end
    end
    formatted_string = formatted_array.join(' ')
    puts formatted_string
    formatted_string
  end

  def encoding_process
    @result = []

    while @encode_buffer.any?
      # matched_in_encode_buffer
      pointer = Pointer.new(0, 0, @encode_buffer[0])
      (1..@buffer_size).reverse_each do |num|
        matched_string = @matched_buffer.join
        compared_substring = @encode_buffer[0, num].join
        if matched_index = matched_string.index(compared_substring)
          pointer.distance = @matched_buffer.count { _1.nil? } + matched_index
          pointer.length = compared_substring.length
          pointer.last_char = @encode_buffer[pointer.length] || @remain_to_encode[0]
          break
        end
      end
      @result << pointer
      slide(pointer.length + 1)
    end
  end

  # 三個區塊都滑動一定單位
  def slide(distance)
    @matched_buffer.shift(distance)
    @matched_buffer.push(*@encode_buffer.shift(distance))
    @encode_buffer.push(*@remain_to_encode.shift(distance))
  end
end
