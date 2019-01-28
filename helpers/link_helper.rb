module LinkHelper
  def date_link_for(date)
    Date.parse(date).strftime("/%Y/%m/%d")
  end

  
end
