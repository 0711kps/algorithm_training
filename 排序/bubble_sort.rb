# 禁止使用 .sort
# 回傳經過昇序排列的數列
# 時間雜度n^2
def bubble(numbers)
  (0..numbers.length-2).each do |i|
    (0..numbers.length-2).each do |j|
      swap(numbers, j, j+1) if numbers[j] > numbers[j+1]
      p numbers
    end
  end
  numbers
end

def swap(numbers, a, b)
  tmp = numbers[a]
  numbers[a] = numbers[b]
  numbers[b] = tmp
  numbers
end
