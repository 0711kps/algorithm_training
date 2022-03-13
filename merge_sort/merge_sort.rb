class Array
  def merge_sort
    return self.sort if self.length < 4

    merge_sort_process(self[0..self.length/2], self[self.length/2+1..])
  end

  private

  def merge_sort_process(l_list, r_list)
    l_list = merge_sort_process(l_list[0...l_list.length/2], l_list[l_list.length/2...l_list.length]) if l_list.length > 1
    r_list = merge_sort_process(r_list[0...r_list.length/2], r_list[r_list.length/2...r_list.length]) if r_list.length > 1
    result_list = []
    loop do
      result_list << (l_list[0] < r_list[0] ? l_list : r_list).shift
      break if [l_list, r_list].any? { _1.empty? }
    end
    result_list + l_list + r_list
  end
end

def random_list
  list_length = rand(10..30)
  i = 0
  list = []
  while (i+=1) < list_length
    list << rand(2..999)
  end
  list
end

src_list = random_list
sorted_list = src_list.merge_sort
puts "from this:"
p src_list
puts "to this:"
p sorted_list
