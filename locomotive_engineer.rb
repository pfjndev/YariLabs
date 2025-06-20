class LocomotiveEngineer
  def self.generate_list_of_wagons(*args)
    # Convert arguments into an array using splat operator
    args
  end

  def self.fix_list_of_wagons(each_wagons_id, missing_wagons)
    # Remove first and second elements from wagons
    first, second, *rest = each_wagons_id
    
    # Separate first element from the other
    head, *leftover = rest
    
    # Add all elements from missing wagons to wagons
    # Also re-add first and second elements from og array
    [head, *missing_wagons, *leftover, first, second]
  end

  def self.add_missing_stops(route, **additional_stops)
    # Convert the keyword arguments into a stops array
    # stops = additional_stops.values
    # Merge the route hash with the stops array
    {**route, stops: additional_stops.values}
  end

  def self.extend_route_information(route, more_route_information)
    # Merge route information - the route should contain all information
    # from both hashes with more_route_information taking precedence
    {**route, **more_route_information}
  end
end
