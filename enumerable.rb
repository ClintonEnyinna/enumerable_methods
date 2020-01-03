# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    each do |i|
      yield i
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    (0...to_a.length).each do |i|
      yield(to_a[i], i)
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    arr = []
    to_a.my_each do |num|
      bool = yield num
      bool ? arr.push(num) : ''
    end
    arr
  end

  def my_all?(arg=false)
    to_a.my_each { |num| return false unless yield num } if block_given?
      
    to_a.my_each { |obj| return false unless obj} unless arg
    if arg.class.to_s === "Regexp"
      to_a.my_each { |obj| return false unless arg.match? obj.to_s }
    elsif arg.class.to_s === "Class"
      to_a.my_each { |obj| return false unless obj.is_a? arg }
    end
    true
  end

  def my_any?(arg=true)
    to_a.my_each { |num| return true if yield num } if block_given?
      
    to_a.my_each { |obj| return true if obj} if arg 
    if arg.class.to_s === "Regexp"
      to_a.my_each { |obj| return true if arg.match? obj.to_s }
    elsif arg.class.to_s === "Class"
      to_a.my_each { |obj| return true if obj.is_a? arg }
    end
    false
  end

  def my_none?(arg=true)
    to_a.my_each { |num| return false if yield num } if block_given?
      
    to_a.my_each { |obj| return false if obj} if arg 
    if arg.class.to_s === "Regexp"
      to_a.my_each { |obj| return false if arg.match? obj.to_s }
    elsif arg.class.to_s === "Class"
      to_a.my_each { |obj| return false if obj.is_a? arg }
    end
    true
  end

  def my_count(arg = false)
    if block_given?
      return 'Error: arg and block not allowed at the same time' if arg

      count = 0
      to_a.my_each do |item|
        count += 1 if yield item
      end
    else
      return length unless arg

      count = 0
      to_a.my_each do |item|
        count += 1 if item == arg
      end
      count
    end
    count
  end

  def my_map
    return to_enum unless block_given?
    arr = []
    to_a.my_each do |item|
      arr.push(yield item)
    end
    arr
  end

  def my_inject(arg = false)
    if arg
      puts "#{arg.class}"
      if arg.class.to_s === 'Symbol' && !block_given?
        acc = to_a[0]
        (1...to_a.length).my_each { |i| acc = acc.send(arg.to_s, to_a[i])}
      else
        acc = arg
        (0...to_a.length).my_each { |i| acc = yield(acc, to_a[i]) }
      end
    else
      acc = to_a[0]
      (1...to_a.length).my_each { |i| acc = yield(acc, to_a[i]) }
    end
    acc
  end
end

# my_each
# puts (5..10).my_each

# my_each_with_index
# (5..10).my_each_with_index { |num, index| puts "#{num} #{index}" }

# my_select
# puts "my_select method : #{[18, 22, 33, 3, 5, 6].my_select}"

# my_all?
# puts "my_all? method : #{[18, 22, 33, 3, 5, '6'].my_all?(Numeric)}"
# puts "my_all? method : #{%w[ cat bat cup ].my_all?(/t/)}"
# puts "my_all? method : #{[18, 22, 33, 3, 5].my_all? {|num| num > 2}}"
# puts "my_all? method : #{[nil, true, 99].my_all?}"
# puts "my_all? method : #{[].my_all?}"

# my_any?
# puts "my_any? method : #{[18, 22, 33, 3, 5, '6'].my_any?(Numeric)}"
# puts "my_any? method : #{%w[ cat bat cup ].my_any?(/t/)}"
# puts "my_any? method : #{[18, 22, 33, 3, 5].my_any? {|num| num > 2}}"
# puts "my_any? method : #{[nil, true, 99].my_any?}"
# puts "my_any? method : #{[].my_any?}"

# my_none?
# puts "my_none? method : #{%w{ant bear cat}.my_none? { |word| word.length >= 4 }}"
# puts "my_none? method : #{%w{ant bear cat}.none?(/d/)}"
# puts "my_none? method : #{[1, 3.14, 42].none?(Float)}"
# puts "my_none? method : #{[nil, false, true].my_none? }"

# my_count
# puts "my_count method : #{[18, 22, 33, 22, 4].my_count(22)}"

# my_map - with Proc
# puts "my_map method : #{[1, 2, 3, 4].my_map { |num| num * 2 }}"

# test_block = Proc.new { |num| num * 2 }
# puts "my_map method : #{[1, 2, 3, 4].my_map(&test_block)}"

# my_inject
puts "my_inject method : #{[2, 4, 5].my_inject(:-)}"
puts "my_inject method : #{[2, 4, 5].my_inject {|num, sum| num + sum}}"

# def multiply_els(arr)
#   arr.my_inject { |acc, nxt| acc * nxt }
# end

# puts multiply_els([2, 4, 5])
