# frozen_string_literal: true

module Enumerable
  def my_each
    each do |i|
      yield i
    end
    self
  end

  def my_each_with_index
    (0...to_a.length).each do |i|
      yield(to_a[i], i)
    end
    self
  end

  def my_select
    arr = []
    to_a.my_each do |num|
      yield num ? arr.push(num) : ''
    end
    arr
  end

  def my_all?
    to_a.my_each do |num|
      return false unless yield num
    end
    true
  end

  def my_any?
    to_a.my_each do |num|
      return true if yield num
    end
    false
  end

  def my_none?
    if block_given?
      to_a.my_any?(&Proc.new)
    else
      to_a.length.positive?
    end
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
    arr = []
    to_a.my_each do |item|
      arr.push(yield item)
    end
    arr
  end

  def my_inject(arg = false)
    if arg
      acc = arg
      (0...to_a.length).my_each { |i| acc = yield(acc, to_a[i]) }
    else
      acc = to_a[0]
      (1...to_a.length).my_each { |i| acc = yield(acc, to_a[i]) }
    end
    acc
  end
end

# my_each
# (5..10).my_each { |num| puts "#{num}" }

# my_each_with_index
# (5..10).my_each_with_index { |num, index| puts "#{num} #{index}" }

# my_select
# puts "my_select method : #{[18, 22, 33, 3, 5, 6].my_select { |num| num > 10 }}"

# my_all?
# puts "my_all? method : #{[18, 22, 33].my_all? { |num| num > 17 }}"

# my_any?
# puts "my_any? method : #{[18, 22, 33].my_any? { |num| num > 30 }}"

# my_none?
# puts "my_none? method : #{[18, 22, 33].my_none? { |num| num > 32 }}"

# my_count
# puts "my_count method : #{[18, 22, 33, 22, 4].my_count(22)}"

# my_map - with Proc
# puts "my_map method : #{[1, 2, 3, 4].my_map { |num| num * 2 }}"

# test_block = Proc.new { |num| num * 2 }
# puts "my_map method : #{[1, 2, 3, 4].my_map(&test_block)}"

# my_inject
puts "my_inject method : #{[2, 4, 5].my_inject(2) { |result, element| result + element }}"

# def multiply_els(arr)
#   arr.my_inject { |acc, nxt| acc * nxt }
# end

# puts multiply_els([2, 4, 5])
