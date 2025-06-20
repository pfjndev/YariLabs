require_relative 'boutique_inventory'

# Example usage
inventory = BoutiqueInventory.new([
  {price: 65.00, name: "Maxi Brown Dress", quantity_by_size: {s: 3, m: 7, l: 8, xl: 4}},
  {price: 50.00, name: "Red Short Skirt", quantity_by_size: {}},
  {price: 29.99, name: "Black Short Skirt", quantity_by_size: {s: 1, xl: 4}},
  {price: 20.00, name: "Bamboo Socks Cats", quantity_by_size: {s: 7, m: 2}}
])

# Test the methods
puts "First item name: #{inventory.items.first.name}"
puts "First item price: #{inventory.items.first.price}"
puts "Number of items: #{inventory.items.size}"
puts
puts "Item names (sorted): #{inventory.item_names}"
puts "Total stock: #{inventory.total_stock}"
