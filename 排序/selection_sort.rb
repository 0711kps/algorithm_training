# 禁用 .sort 與 .max
# 回傳昇序數列
# 與 buddle 不同, 每次iterate, 可以忽略掉一個元素, 所以時間複雜度是n!

def selection(numbers, result: [])
  min = nil
  numbers.each do |i|
    min = i if min.nil? || i < min
  end
  result << min
  selection(numbers.delete_if { _1 == min }, result: result) if numbers.length > 1
  result
end

p selection([8,1,4,20,3,4])
