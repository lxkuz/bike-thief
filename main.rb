require 'benchmark'

require './algorithms/dijkstra'
require './dijkstra'

# ---------------- TESTS ---------------------

def simple_test(algorithm_class)
  puts "1. Simple test"
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
  result = algorithm.calc

  raise 'FAILED' if result != test_result
  puts "OK: SOLUTION FOUND IN #{result.count} STEPS"
  puts result.inspect
  puts "--------------------------------------------"
end

def mid_test(algorithm_class)
  puts "2. Mid level test"
  from = [0, 0, 0, 0]
  to = [1, 2, 1, 5]
  exclude = [[1, 2, 1, 6 ], [0, 2, 1, 6 ], [1, 1, 1, 6 ], [0, 1, 1, 6 ] ]
  
  algorithm = algorithm_class.new(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 10
  )
  result = nil
  mark = Benchmark.measure do
    result = algorithm.calc
  end
  raise 'FAILED' if result.nil?
  puts "OK: SOLUTION FOUND IN #{result.count} STEPS"
  puts result.inspect
  puts "Benchmark: #{mark}"
  puts "--------------------------------------------"
end

def hard_test(algorithm_class)
  puts "3. Hard level test"
  from = [0, 0, 0, 0, 0, 0]
  to = [1, 2, 1, 5, 0, 6]
  exclude = [
    [1, 2, 1, 6, 0, 6], [0, 2, 1, 6, 0, 6], [2, 2, 2, 6, 0, 6],
    [1, 2, 1, 1, 0, 1], [1, 2, 1, 1, 0, 2], [1, 2, 1, 1, 0, 4],
    [1, 2, 0, 1, 0, 5], [1, 1, 1, 1, 0, 1], [1, 1, 1, 1, 0, 2],
    [1, 1, 1, 1, 0, 4], [1, 1, 0, 1, 0, 5], [1, 2, 1, 4, 0, 2],
    [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 9], [1, 0, 0, 0, 0, 9],
    [1, 2, 1, 7, 0, 9], [1, 2, 1, 6, 0, 9], [1, 2, 1, 5, 0, 7]
  ]
  
  algorithm = algorithm_class.new(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 10
  )
  result = nil
  mark = Benchmark.measure { result = algorithm.calc }
  raise 'FAILED' if result.nil?
  puts "OK: SOLUTION FOUND IN #{result.count} STEPS"
  puts result.inspect
  puts "Benchmark: #{mark}"
  puts "--------------------------------------------"
end

def trap_test(algorithm_class)
  puts "4. Trap test"
  from = [0, 0]
  to = [2, 2]
  exclude = [[2, 1], [1, 2], [3, 2], [2, 3]]
  
  algorithm = algorithm_class.new(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 4
  )
  result = algorithm.calc
  raise 'FAILED' unless result.nil?
  puts "OK: THERE IS NO SOLUTION"
  puts "--------------------------------------------"
end


def dijkstra_failing_test(algorithm_class)
  puts "5. Dijkstra failing test"
  from = [0]
  to = [3]
  exclude = [[4]]
  
  result = algorithm_class.new(
    exclude: exclude,
    initial_state: from,
    final_state: to,
    disk_size: 6
  ).calc
  if result.nil?
    puts "FAILED, this is a lack of Dijkstra's algorithm" 
  else
    puts "OK: SOLUTION FOUND IN #{result.count} STEPS"
    puts result.inspect
  end
  puts "--------------------------------------------"
end

# --------------------- START --------------------

def start_tests(algorithm_class)
  simple_test(algorithm_class)
  mid_test(algorithm_class)
  hard_test(algorithm_class)
  trap_test(algorithm_class)
  dijkstra_failing_test(algorithm_class)
end

def start
  puts "-------------- Dijkstra's Algorithm --------------"
  start_tests(Dijkstra)
end

start
