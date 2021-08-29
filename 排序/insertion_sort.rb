# 禁用
# 回傳昇序數列
# 平均來說, big O與 selection 一樣是n^2
# 但最佳情況下會是n(立刻找到位置插入的話), 而selection為了確認最小值必須全部迭代一次

def insertion(numbers)
  result = []
  while numbers.any?
    result = insert(result, numbers.shift)
  end
  result
end

def insert(left_numbers, target)
  i = 0
  while i < left_numbers.length
    break if left_numbers[i] > target

    i += 1
  end
  left_numbers.insert(i, target)
end

p insertion([9,11,7,3,6,5])
