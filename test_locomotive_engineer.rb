require_relative 'locomotive_engineer'

puts "=== Locomotive Engineer Exercise Demo ==="
puts

# 1. Generate list of wagons
puts "1. Generate list of wagons using splat operator:"
wagons = LocomotiveEngineer.generate_list_of_wagons(1, 7, 12, 3, 14, 8, 5)
puts "Input: 1, 7, 12, 3, 14, 8, 5"
puts "Output: #{wagons.inspect}"
puts "This converts multiple arguments into a single array"
puts

# 2. Fix list of wagons
puts "2. Fix list of wagons using array decomposition:"
original_wagons = [1, 2, 5, 4, 7, 6, 3, 8]
missing_wagons = [9, 10]
puts "Original wagons: #{original_wagons.inspect}"
puts "Missing wagons: #{missing_wagons.inspect}"

fixed_wagons = LocomotiveEngineer.fix_list_of_wagons(original_wagons, missing_wagons)
puts "Fixed wagons: #{fixed_wagons.inspect}"
puts "This removes first two elements, moves them to end, and adds missing wagons"
puts

# 3. Add missing stops using keyword arguments
puts "3. Add missing stops using keyword arguments:"
route = { from: "Berlin", to: "Hamburg" }
puts "Original route: #{route.inspect}"
puts "Adding stops with keyword arguments: stop_1, stop_2, stop_3"

complete_route = LocomotiveEngineer.add_missing_stops(route, stop_1: "Leipzig", stop_2: "Hannover", stop_3: "Frankfurt")
puts "Complete route: #{complete_route.inspect}"
puts "This converts keyword arguments into a stops array"
puts

# 4. Extend route information
puts "4. Extend route information using hash merging:"
route = { from: "Berlin", to: "Hamburg" }
more_info = { duration: "2h", distance: "200km" }
puts "Original route: #{route.inspect}"
puts "Additional info: #{more_info.inspect}"

extended_route = LocomotiveEngineer.extend_route_information(route, more_info)
puts "Extended route: #{extended_route.inspect}"
puts "This merges two hashes with the second taking precedence"
puts

puts "=== Key Concepts Explained ==="
puts
puts "1. SPLAT OPERATOR (*) for arrays:"
puts "   - *args converts multiple arguments into an array"
puts "   - *array spreads array elements"
puts "   - [1, *[2, 3], 4] becomes [1, 2, 3, 4]"
puts

puts "2. DOUBLE SPLAT (**) for hashes:"
puts "   - **hash spreads hash key-value pairs"
puts "   - {a: 1, **{b: 2, c: 3}} becomes {a: 1, b: 2, c: 3}"
puts

puts "3. ARRAY DECOMPOSITION:"
puts "   - first, second, *rest = [1, 2, 3, 4, 5]"
puts "   - first = 1, second = 2, rest = [3, 4, 5]"
puts

puts "4. KEYWORD ARGUMENTS:"
puts "   - def method(**kwargs) collects keyword args into hash"
puts "   - kwargs.values extracts all values as array"
puts "   - Used to convert stops into structured format"
