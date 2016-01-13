class Fibonacci

  def is_fibonacci?(num)
    arr = [0, 1]
  while num > arr.last
    x, y = arr.pop(2)
    arr.push(x, y, x + y)
  end


    return true if num == arr.last
    return false
  end

  def fibonacci_generator(num)
    return [] if num <= 0

    case num
    when 1
      [0]
    when 2
      [0, 1]
    else
      (num-2).times.each_with_object([0, 1]) { |a, b| b << b[-2] + b[-1]}
    end

  end

end