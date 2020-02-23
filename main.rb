# rubocop:disable Style/CaseEquality

module Enumerable
  def my_each
    i = 0
    while i < length
      yield self[i]
      i += 1
    end
  end
  def my_each_with_index
    i = 0
    while i < length
      yield(self[i],i)
      i += 1
    end
  end
  def my_select
    temp = []
    i = 0
    while i < length
      temp.push(self[i]) if yield(self[i])
      i += 1
    end
    return temp
  end
  def my_all?
    i = 0
    while i < length
      return false if !yield(self[i])
      i += 1
    end
    return true
  end
  def my_any?
    i = 0
    while i < length
      return true if yield(self[i])
      i += 1
    end
    return false
  end
  def my_none?
    i = 0
    while i < length
      return false if yield(self[i])
      i += 1
    end
    return true
  end
  def my_count(filter = nil)
    return self.length if !filter
    temp = []
    count = 0
    i = 0
    if block_given?
      while i < length
        count += 1 if yield(self[i])
        i += 0
      end
    else
      while i < length
        count += 1 if self[i] == filter
        i += 0
      end
    end
    return count
  end
  def my_map
    return self if !block_given?
    temp = []
    i = 0
    while i < length
      temp.push(yield(self[i]))
      i += 1
    end
    return temp
  end
  def my_inject (initial = nil, sym  = nil)
    i = 1
    memo = self[0]
    sym, initial = initial, sym if initial.is_a? Symbol

    if initial
      memo = initial  
      i = 0
    end
    
    if block_given?
      while i < length
        memo = yield memo, self[i]
        i += 1
      end
    else 

      return 'Please enter a Math symbol or supply a block' if !sym && !initial
      
      while i < length
        memo = memo.send(sym,self[i])
        i += 1
      end
    end
    memo
  end

end

arr = [5,6,7,8,9,10]
puts "my_each method output :"
arr.my_each do |num|
  puts num.to_s
end
puts "my_each_with_index method output :"

arr.my_each_with_index do |v,i|
  puts "#{i} : #{v}"
end

puts "my_select method output :"
select_output = arr.my_select do |v|
  v > 2
end
puts select_output

puts "my_all? method output :"
all = arr.my_all? do |v|
  v > 10
end
puts all.to_s

puts "my_any? method output :"
any = arr.my_any? do |v|
  v > 4
end
puts any.to_s

puts "my_none? method output :"
none = arr.my_none? do |v|
  v > 10
end
puts none.to_s

puts "my_count method output :"
count = arr.count do |v|
  v > 2
end
puts count.to_s

puts "my_map method output :"
map = arr.my_map do |v|
  v * 3
end
puts map

puts "my_inject method output :"
inject = arr.my_inject do |memo, num|
  memo * num
end

puts inject

puts "inject method output :"
inject = arr.inject(:*)
puts inject

# rubocop:enable Style/CaseEquality
