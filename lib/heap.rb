class Heap

  def initialize
    @start = 1
    @size = 0
    @array = [nil]
  end

  def add(item)
    @size = @size+1
    @array.push(item)
    heapup
    return @array
  end

  def remove
    return nil if @size == 0
    value = @array[1]
    last = @array.last
    @array[1] = last
    heapdown
    @array.pop
    @size = @size -1
    return value
  end

  def peek
    return @array[1]
  end

  def empty?
    return true if @size == 0
    false
  end

  private

  def heapup
    last_position = @size
    target = @array[last_position]
    position = last_position
    while position > @start && target < @array[position/2]
      swap_value = @array[position/2]
      @array[position] = swap_value
      @array[position/2] = target
      position = position/2
    end
  end

  def heapdown
    target = @array[@start]
    position = @start
    while position < @size-1
      if @array[position*2] && @array[(position*2)+1] && greater(@array[(position*2)+1], @array[(position*2)])
        swap = @array[position*2]
        @array[position*2] = target
        @array[position] = swap
        position = position*2
      elsif @array[(position*2)+1]
        swap = @array[(position*2)+1]
        @array[(position*2)+1] = target
        @array[position] = swap
        position = (position*2)+1
      else
        break
      end
    end
  end

  def greater(target, other)
    return false if target.nil?
    return true if other.nil?
    if target > other
      return true
    else
      return false
    end
  end

end