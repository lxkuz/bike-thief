require './dijkstra'

# ---------------- TESTS ---------------------

def simple_test(algorithm_class)
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

  algorithm = algorithm_class.new(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 10
  )

  raise 'FAILED' if algorithm.calc != test_result
  puts "OK"
end

def hard_test(algorithm_class)
  p "hard test"
  from = [0, 0, 0, 0, 0, 0]
  to = [1, 2, 1, 5, 0, 6]
  exclude = [[1, 2, 1, 6, 0, 6], [0, 2, 1, 6, 0, 6] ]
  
  algorithm = algorithm_class.new(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 10
  )
  raise 'FAILED' if algorithm.calc.nil?
  puts "OK"
end

def trap_test(algorithm_class)
  p "trap test"
  from = [0, 0]
  to = [2, 2]
  exclude = [[2, 1], [1, 2], [3, 2], [2, 3]]
  
  result = algorithm_class.new(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 4
  ).calc
  raise 'FAILED' unless result.nil?
  puts "OK"
end


def dijkstra_failing_test(algorithm_class)
  p "dijkstra failing test"
  from = [0]
  to = [3]
  exclude = [[4]]
  
  result = algorithm_class.new(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 6
  ).calc

  puts "FAILED, this is a lack of Dijkstra's algorithm" if result.nil?
end

# --------------------- START --------------------

def start

  algorithm_class = Dijkstra
  simple_test(algorithm_class)
  hard_test(algorithm_class)
  trap_test(algorithm_class)
  dijkstra_failing_test(algorithm_class)
end

start
