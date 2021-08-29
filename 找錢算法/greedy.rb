# 假設一般在賣場的狀況找錢演算法可用單位1, 5, 10, 50, 100,500
# 給定一個要找的金額
# 找出一個演算法, 可以以最少的硬幣/鈔票數量找客人錢
# 回傳對應六種貨幣單位數量的陣列

# 按照幣值由大到小去除, 用餘數送至下一輪, 時間複雜度n(n=units length)
def greedy(num, units: [500, 100, 50, 10, 5, 1])
  return [] if units.empty?

  [num / units[0]] + greedy(num % units[0], units: units[1..])
end

def print_greedy(num)
  puts "target:\t#{num}"
  puts [500, 100, 50, 10, 5, 1].zip(greedy(num)).map { _1.join(' x ') }
end

# 注意, 假如在500後面加入450幣值的貨幣, 這個算法可能會給出不對的答案, 例如: 輸入900, 會回500x1+100x4=5個, 但實際上只需要450x2=2個
# 在排序過得貨幣列表中, 如果相依的兩個值相除不為整數, 這個演算法可能會出錯
print_greedy(421)
