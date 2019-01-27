module PlaceHelper
  def find_place(query)
    data.places.find { | slug, place | slug == query}
  end
end
