require 'pry'

# --------------------- CALCULATION ------------------------------

class Lee

  def initialize(exclude:, initial_state:, final_state:, disk_size:)
    @basic_exclude = @exclude = exclude
    @initial_state = initial_state
    @final_state = final_state
    @disk_size = disk_size
    @max_size = @disk_size ** @initial_state.size
  end

  def calc
    @call_count = 0
    @exclude = Set.new(@basic_exclude)
    @data = {
      @initial_state => { weight: 0, parent: nil }
    }

    add_data_items(data: @data, states: [@initial_state], weight: 0)
    data_pointer = @data[@final_state]
    if data_pointer
      answer = [@final_state]
      loop do
        parent = data_pointer[:parent]
        break if parent.nil?
        answer.prepend(parent)
        data_pointer = @data[parent]
      end
      answer
    else
      nil
    end
  end

  private

  def build_data_item(parent, weight)
    # puts "PROGRESS: #{@data.size * 100 / @max_size} %"
    {
      parent: parent,
      weight: weight
    }
  end

  def add_data_items(data:, states:, weight:)
    return if @stop || states.empty?

    states.each{|s| @exclude.add(s)}
    next_weight = weight + 1
    next_wave_states = []
    states.each_with_index do |state, index|
      next_states = get_neighboring_states(state, @exclude)
      next_states.each{|s| @exclude.add(s)}
      next_states.each do |next_state|
        data[next_state] = build_data_item(state, next_weight)
        if next_state == @final_state
          @stop = true
          return 
        end
      end
      next_wave_states += next_states
    end
  
    add_data_items(
      data: data,
      states: next_wave_states,
      weight: next_weight
    )
  end

  def get_neighboring_states(state, exclude)
    arr = []
    (0...state.size).each do |disk_index|
      left_state = roll_disk_left(state, disk_index)
      right_state = roll_disk_right(state, disk_index)
      arr.push(left_state) unless exclude.include?(left_state)
      arr.push(right_state) unless exclude.include?(right_state)
    end
    arr
  end

  def roll_disk_left(state, disk_index)
    res = state.clone
    res[disk_index] -= 1
    res[disk_index] = @disk_size - 1 if res[disk_index] < 0
    res
  end

  def roll_disk_right(state, disk_index)
    res = state.clone
    res[disk_index] += 1
    res[disk_index] = 0 if res[disk_index] == @disk_size
    res
  end
end
