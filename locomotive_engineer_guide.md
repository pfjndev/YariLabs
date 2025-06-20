# Locomotive Engineer Exercise - Complete Guide

## Overview
The Locomotive Engineer exercise teaches you Ruby's **splat operator** (`*`) and **double splat operator** (`**`) for working with arrays and hashes. These are powerful tools for composition and decomposition of collections.

## Key Concepts

### 1. Splat Operator (*) - For Arrays

The splat operator has several uses:

#### A. Collecting Arguments into Arrays
```ruby
def generate_list_of_wagons(*args)
  args  # All arguments become an array
end

generate_list_of_wagons(1, 2, 3, 4) # => [1, 2, 3, 4]
```

#### B. Spreading Arrays
```ruby
arr1 = [1, 2]
arr2 = [3, 4]
combined = [0, *arr1, *arr2, 5]  # => [0, 1, 2, 3, 4, 5]
```

#### C. Array Decomposition (Multiple Assignment)
```ruby
first, second, *rest = [1, 2, 3, 4, 5]
# first = 1
# second = 2  
# rest = [3, 4, 5]
```

### 2. Double Splat Operator (**) - For Hashes

#### A. Collecting Keyword Arguments
```ruby
def add_missing_stops(route, **additional_stops)
  # additional_stops is a hash of all keyword arguments
end

add_missing_stops({from: "A", to: "B"}, layover: "C", stop: "D")
# additional_stops = {layover: "C", stop: "D"}
```

#### B. Spreading Hashes
```ruby
route = {from: "New York", to: "Boston"}
extras = {layover: "DC", departure: "Grand Central"}
complete = {**route, **extras}
# => {from: "New York", to: "Boston", layover: "DC", departure: "Grand Central"}
```

## Exercise Solutions Explained

### Method 1: `generate_list_of_wagons`
```ruby
def self.generate_list_of_wagons(*args)
  args
end
```
**What it does:** Converts multiple arguments into a single array
**Input:** `generate_list_of_wagons(1, 7, 12)`
**Output:** `[1, 7, 12]`

### Method 2: `fix_list_of_wagons` 
```ruby
def self.fix_list_of_wagons(each_wagons_id, missing_wagons)
  first, second, *rest = each_wagons_id
  head, *leftover = rest
  [head, *missing_wagons, *leftover, first, second]
end
```
**What it does:** 
1. Removes first two elements from the wagon list
2. Takes the next element as the new head
3. Inserts missing wagons after the head
4. Moves the original first two elements to the end

**Example:**
- Input: `[1, 2, 5, 4, 7, 6, 3, 8], [9, 10]`
- After decomposition: `first=1, second=2, rest=[5, 4, 7, 6, 3, 8]`
- After second decomposition: `head=5, leftover=[4, 7, 6, 3, 8]`
- Final result: `[5, 9, 10, 4, 7, 6, 3, 8, 1, 2]`

### Method 3: `add_missing_stops`
```ruby
def self.add_missing_stops(route, **additional_stops)
  stops = additional_stops.values
  {**route, stops: stops}
end
```
**What it does:** Takes a route hash and keyword arguments, converts the keyword argument values into a `:stops` array
**Input:** `route = {from: "Berlin", to: "Hamburg"}`, `stop_1: "Leipzig", stop_2: "Hannover"`
**Output:** `{from: "Berlin", to: "Hamburg", stops: ["Leipzig", "Hannover"]}`

### Method 4: `extend_route_information`
```ruby
def self.extend_route_information(route, more_route_information)
  {**route, **more_route_information}
end
```
**What it does:** Similar to method 3, merges route information where the second hash takes precedence for duplicate keys.

## Common Patterns and Tips

### 1. Array Composition
```ruby
# Building arrays from multiple sources
fruits = ["apple", "banana"]
more_fruits = ["orange", "kiwi", "melon", "mango"]
all_fruits = [*fruits, *more_fruits]
```

### 2. Hash Composition  
```ruby
# Merging hashes
inventory = {apple: 6, banana: 2, cherry: 3}
more_items = {orange: 4, kiwi: 1}
full_inventory = {**inventory, **more_items}
```

### 3. Hash Decomposition
```ruby
# Converting hash to arrays
inventory = {apple: 6, banana: 2, cherry: 3}
keys = inventory.keys        # [:apple, :banana, :cherry]
values = inventory.values    # [6, 2, 3]
pairs = inventory.to_a       # [[:apple, 6], [:banana, 2], [:cherry, 3]]
```

### 4. Multiple Assignment with Hashes
```ruby
# Extracting values from hash conversion
x, y, z = inventory.keys
# x = :apple, y = :banana, z = :cherry

x, y, z = inventory.values  
# x = 6, y = 2, z = 3
```

## Practice Exercises

Try these on your own:

1. **Array Manipulation:**
```ruby
# Combine these arrays: [1, 2], [3, 4], [5, 6]
# Expected: [1, 2, 3, 4, 5, 6]
```

2. **Hash Merging:**
```ruby
# Merge these hashes: {a: 1, b: 2}, {c: 3, d: 4}
# Expected: {a: 1, b: 2, c: 3, d: 4}
```

3. **Array Reordering:**
```ruby
# Move first element to end: [1, 2, 3, 4, 5]
# Expected: [2, 3, 4, 5, 1]
```

## Why These Concepts Matter

- **Composition:** Building complex data structures from simpler ones
- **Decomposition:** Breaking down data structures for processing  
- **Flexibility:** Writing methods that can handle variable numbers of arguments
- **Readability:** Making code more expressive and clear
- **Ruby Idioms:** Following Ruby conventions for elegant code

The splat operators are fundamental Ruby tools that you'll use frequently in real applications for handling collections, method arguments, and data transformation.
