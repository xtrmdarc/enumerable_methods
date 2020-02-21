module Enumerable
  def my_each
    for i in (0...self.length)
      yield(self[i])
    end
  end
  def my_each_with_index
    for i in (0...self.length)
      yield(self[i],i)
    end
  end
  def my_select
    temp = []
    for i in (0...self.length)
      temp.push(self[i]) if yield(self[i])
    end
    return temp
  end
  def my_all?
    for i in (0...self.length)
      return false if !yield(self[i])
    end
    return true
  end
  def my_any?
    for i in (0...self.length)
      return true if yield(self[i])
    end
    return false
  end
  def my_none?
    for i in (0...self.length)
      return false if yield(self[i])
    end
    return true
  end
  def my_count(filter = nil)
    return self.length if !filter
    temp = []
    count = 0
    if block_given?
      for i in (0...self.length)
        count += 1 if yield(self[i])
      end
    else
      for i in (0...self.length)
        count += 1 if self[i] == filter
      end
    end
    return count
  end
  def my_map
  end
  def my_inject
  end
  def my_map
  end
end

arr = [5,2,3]
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