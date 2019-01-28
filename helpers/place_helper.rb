module PlaceHelper
  def find_place(query)
    data.places.find { | slug, place | slug == query}
  end

  def find_meal(query)
    data.meals.find { | slug, meal | slug == query}
  end

  def find_transport(query)
    data.transport.find { | slug, transport | slug == query}
  end
end
