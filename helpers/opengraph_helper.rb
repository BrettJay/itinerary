module OpengraphHelper
  def path_to_opengraph_tag
    if @og_image_override.present?
      "#{data.config.site.root_url}images/#{@og_image_override}/"
    else
      "#{data.config.site.root_url}images/"
    end
  end

  def render_page_description
    if current_page.data.meta_description.present?
      current_page.data.meta_description
    else
      "Here is my portfolio for all the reviews, analyses, articles, and barely sober rants I’ve written on all things film."
    end
  end
end
