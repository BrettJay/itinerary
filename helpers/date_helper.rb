module DateHelper
  def dates_in_order
    data.dates.sort{ |a, b| a.to_s.downcase <=> b.to_s.downcase }
  end
end
