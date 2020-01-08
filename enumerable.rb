# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum unless block_given?

    i = 0
    loop do
      yield to_a[i]
      i += 1
      break if i == to_a.length
    end
    to_a
  end

  def my_each_with_index
    return to_enum unless block_given?

    (0...to_a.length).my_each do |i|
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

  def my_all?(arg = false)
    if block_given?
      to_a.my_each { |num| return false unless yield num }
    elsif arg && to_a.length.positive?
      if arg.class.to_s == 'Regexp'
        to_a.my_each { |obj| return false unless arg.match? obj.to_s }
      elsif arg.class.to_s == 'Class'
        to_a.my_each { |obj| return false unless obj.is_a? arg }
      else
        to_a.my_each { |obj| return false unless obj == arg }
      end
    elsif to_a.length.positive?
      to_a.my_each { |obj| return false unless obj }
    end
    true
  end

  def my_any?(arg = false)
    if block_given?
      to_a.my_each { |num| return true if yield num }
    elsif arg && to_a.length.positive?
      if arg.class.to_s == 'Regexp'
        to_a.my_each { |obj| return true if arg.match? obj.to_s }
      elsif arg.class.to_s == 'Class'
        to_a.my_each { |obj| return true if obj.is_a? arg }
      else
        to_a.my_each { |obj| return true if obj == arg }
      end
    elsif to_a.length.positive?
      to_a.my_each { |obj| return true if obj }
    end
    false
  end

  def my_none?(arg = false)
    if block_given?
      to_a.my_each { |num| return false if yield num }
    elsif arg && to_a.length.positive?
      if arg.class.to_s == 'Regexp'
        to_a.my_each { |obj| return false if arg.match? obj.to_s }
      elsif arg.class.to_s == 'Class'
        to_a.my_each { |obj| return false if obj.is_a? arg }
      else
        to_a.my_each { |obj| return false if obj == arg }
      end
    elsif to_a.length.positive?
      to_a.my_each { |obj| return false if obj }
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

  def my_inject(*args)
    if args[0] && !block_given?
      if args.length == 2 && args[1].class.to_s == 'Symbol'
        acc = args[0]
        (0...to_a.length).my_each { |i| acc = acc.send(args[1].to_s, to_a[i]) }
      elsif args[0].class.to_s == 'Symbol'
        acc = to_a[0]
        (1...to_a.length).my_each { |i| acc = acc.send(args[0].to_s, to_a[i]) }
      else
        acc = args
        (0...to_a.length).my_each { |i| acc = yield(acc, to_a[i]) }
      end
    elsif args[0] && block_given?
      acc = args[0]
      (0...to_a.length).my_each { |i| acc = yield(acc, to_a[i]) }
    else
      acc = to_a[0]
      (1...to_a.length).my_each { |i| acc = yield(acc, to_a[i]) }
    end
    acc
  end
end

# my_each
# (5..10).my_each { |num| puts num }

# my_each_with_index
# (5..10).my_each_with_index { |num, index| puts "#{num} #{index}" }

# my_select
# puts "my_select method : #{[18, 22, 33, 3, 5, 6].my_select}"

# my_all?
# puts "my_all? method : #{[18, 22, 33, 3, 5, '6'].my_all?(Numeric)}"
# puts "my_all? method : #{%w[ cat bat cup ].my_all?(/t/)}"
# puts "my_all? method : #{[18, 22, 33, 3, 5].my_all? {|num| num > 2}}"
# puts "my_all? method : #{[true, true, false].my_all?}"
# puts "my_all? method : #{[].my_all?}"
# puts "my_all? method : #{[3, 3, 3].my_all?(3)}"

# my_any?
# puts "my_any? method : #{[18, 22, 33, 3, 5, '6'].my_any?(Numeric)}"
# puts "my_any? method : #{%w[ cat bat cup ].my_any?(/d/)}"
# puts "my_any? method : #{[18, 22, 33, 3, 5].my_any? {|num| num > 2}}"
# puts "my_any? method : #{[nil, true, 99].my_any?}"
# puts "my_any? method : #{[].my_any?}"
# puts [1, 2, 3].my_any?(4)

# my_none?
# puts "my_none? method : #{%w{ant bear cat}.my_none? { |word| word.length >= 4 }}"
# puts "my_none? method : #{%w{ant bear cat}.none?(/d/)}"
# puts "my_none? method : #{[1, 3.14, 42].none?(Float)}"
# puts "my_none? method : #{[nil, false].my_none? }"
# puts "my_none? method : #{[1, 2 , 3].my_none?}"
# puts "my_none? method : #{[].my_none?}"

# my_count
# puts "my_count method : #{[18, 22, 33, 22, 4].my_count(22)}"

# my_map - with Proc
# puts "my_map method : #{[1, 2, 3, 4].my_map { |num| num * 2 }}"

# test_block = Proc.new { |num| num * 2 }
# puts "my_map method : #{[1, 2, 3, 4].my_map(&test_block)}"

# my_inject
# puts "my_inject method : #{ [2, 4, 5].my_inject(:-) }"
# puts "my_inject method : #{ [2, 4, 5].my_inject(3) {|num, sum| num + sum} }"
# puts "my_inject method : #{ [2, 4, 5].my_inject {|num, sum| num + sum} }"
# puts "my_inject method : #{ [2, 4, 5].my_inject(9, :+)} "

# def multiply_els(arr)
#   arr.my_inject { |acc, nxt| acc * nxt }
# end

# puts multiply_els([2, 4, 5])
