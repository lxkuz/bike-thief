# --------------------- CALCULATION ------------------------------

def code_lock_selection(exclude:, initial_state:, final_state:, disk_size:)
  result = code_lock_selection_step(
    history: [initial_state],
    exclude: exclude,
    state: initial_state,
    final_state: final_state,
    disk_size: disk_size
  )
  result
end

def code_lock_selection_step(history:, exclude:, state:, final_state:, disk_size:)
  return history if state == final_state
  possible_states = get_neighboring_states(state, disk_size, exclude + history)
  return nil if possible_states.empty?
  min_distance = calc_distance(state, final_state, disk_size)
  next_state = possible_states.first
  possible_states.each_with_index do |possible_state|
    possible_distance = calc_distance(possible_state, final_state, disk_size)
    if possible_distance < min_distance
      min_distance = possible_distance
      next_state = possible_state
    end
  end
  puts "NEXT STEP: #{next_state}"
  history.push(next_state)
  code_lock_selection_step(
    history: history,
    exclude: exclude,
    state: next_state,
    final_state: final_state,
    disk_size: disk_size
  )
end

def get_neighboring_states(state, disk_size, exclude)
  arr = []
  (0...state.size).each do |disk_index|
    left_state = roll_disk_left(state, disk_index, disk_size)
    right_state = roll_disk_right(state, disk_index, disk_size)
    arr.push(left_state) unless exclude.include?(left_state)
    arr.push(right_state) unless exclude.include?(right_state)
  end
  arr
end

def roll_disk_left(state, disk_index, disk_size)
  res = state.clone
  res[disk_index] -= 1
  res[disk_index] = disk_size - 1 if res[disk_index] < 0
  res
end

def roll_disk_right(state, disk_index, disk_size)
  res = state.clone
  res[disk_index] += 1
  res[disk_index] = 0 if res[disk_index] == disk_size
  res
end

def calc_distance(left_state, right_state, disk_size)
  left_state.zip(right_state).map do |left_point, right_point|
    calc_disk_distance(left_point, right_point, disk_size)
  end.sum
end

def calc_disk_distance(left_point, right_point, disk_size)
  [
    (left_point - right_point).abs,
    (left_point - disk_size - right_point).abs
  ].min
end

# ---------------- TESTS ---------------------

def simple_test
  p "simple test"
  from = [0, 0, 0]
  to = [1, 1, 1]
  exclude = [[0, 0, 1], [1, 0, 0]]
  
  test_result = [
    [0, 0, 0],
    [0, 1, 0],
    [1, 1, 0],
    [1, 1, 1]
  ]

  raise 'wrong' if code_lock_selection(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 10
  ) != test_result

  puts "OK"
end

def hard_test
  p "hard test"
  from = [0, 0, 0, 0, 0, 0]
  to = [1, 2, 1, 5, 0, 6]
  exclude = [[1, 2, 1, 6, 0, 6], [0, 2, 1, 6, 0, 6] ]
  
  code_lock_selection(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 10
  )

  puts "OK"
end

def trap_test
  p "trap test"
  from = [0, 0]
  to = [2, 2]
  exclude = [[2, 1], [1, 2], [3, 2], [2, 3]]
  
  result = code_lock_selection(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 4
  )

  puts "OK" if result.nil?
end

# --------------------- START --------------------

def start
  simple_test
  hard_test
  trap_test
end

start
