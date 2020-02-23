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
      yield(self[i], i)
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
    temp
  end

  def my_all?
    i = 0
    while i < length
      return false unless yield(self[i])

      i += 1
    end
    true
  end

  def my_any?
    i = 0
    while i < length
      return true if yield(self[i])

      i += 1
    end
    false
  end

  def my_none?
    i = 0
    while i < length
      return false if yield(self[i])

      i += 1
    end
    true
  end

  def my_count(filter = nil)
    return length unless filter

    count = 0
    i = 0
    while i < length
      if block_given?
        count += 1 if yield(self[i])
      elsif self[i] == filter
        count += 1
      end
      i += 0
    end
    count
  end

  def my_map(proc = nil)
    return self unless block_given? || proc

    temp = []
    i = 0
    if proc
      while i < length
        temp.push(proc.call(self[i]))
        i += 1
      end
    else
      while i < length
        temp.push(yield(self[i]))
        i += 1
      end
    end
    temp
  end

  def my_inject(initial = nil, sym = nil)
    i = 1
    memo = self[0]
    sym, initial = initial, sym if initial.is_a? Symbol
    if initial
      memo = initial
      i = 0
    end

    while i < length
      memo = if block_given?
               yield memo, self[i]
             else
               memo.send(sym, self[i])
             end
      i += 1
    end
    memo
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end

my_map_proc = proc do |el|
  el * 3
end

arr = [2, 4, 5]
puts 'my_each method output :'
arr.my_each do |num|
  puts num.to_s
end
puts 'my_each_with_index method output :'

arr.my_each_with_index do |v, i|
  puts "#{i} : #{v}"
end

puts 'my_select method output :'
select_output = arr.my_select do |v|
  v > 2
end
puts select_output

puts 'my_all? method output :'
all = arr.my_all? do |v|
  v > 10
end
puts all.to_s

puts 'my_any? method output :'
any = arr.my_any? do |v|
  v > 4
end
puts any.to_s

puts 'my_none? method output :'
none = arr.my_none? do |v|
  v > 10
end
puts none.to_s

puts 'my_count method output :'
count = arr.count do |v|
  v > 2
end
puts count.to_s

puts 'my_map method output :'
map = arr.my_map do |v|
  v * 3
end
puts map

puts 'my_inject method output :'
inject = arr.my_inject do |memo, num|
  memo * num
end
puts inject

puts 'inject method output :'
inject = arr.inject(:*)
puts inject

puts 'multiply_els method output :'
inject = multiply_els([2, 4, 5])
puts inject

puts 'my_map method with proc output :'
map = arr.my_map(my_map_proc)
puts map
