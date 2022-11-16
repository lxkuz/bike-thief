# --------------------- CALCULATION ------------------------------

class Dijkstra

  def initialize(exclude:, initial_state:, final_state:, disk_size:)
    @exclude = exclude
    @initial_state = initial_state
    @final_state = final_state
    @disk_size = disk_size
  end

  def calc
    result = code_lock_selection_step(
      history: [@initial_state],
      state: @initial_state
    )
    result
  end

  private

  def code_lock_selection_step(history:, state:)
    return history if state == @final_state
    possible_states = get_neighboring_states(state,@exclude + history)
    return nil if possible_states.empty?
    min_distance = calc_distance(state, @final_state)
    next_state = possible_states.first
    possible_states.each_with_index do |possible_state|
      possible_distance = calc_distance(possible_state, @final_state)
      if possible_distance < min_distance
        min_distance = possible_distance
        next_state = possible_state
      end
    end
    history.push(next_state)
    code_lock_selection_step(
      history: history,
      state: next_state
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

  def calc_distance(left_state, right_state)
    left_state.zip(right_state).map do |left_point, right_point|
      calc_disk_distance(left_point, right_point)
    end.sum
  end

  def calc_disk_distance(left_point, right_point)
    [
      (left_point - right_point).abs,
      (left_point - @disk_size - right_point).abs
    ].min
  end

end
