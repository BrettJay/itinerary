# --------------------------------------------------------------------------------------------------
# Helpers
# --------------------------------------------------------------------------------------------------

helpers do
  # Helpers are defined in and can be added to `helpers/custom_helpers.rb`.
  # In case you require helpers within `config.rb`, they can be added here.
end

# --------------------------------------------------------------------------------------------------
# Extensions
# --------------------------------------------------------------------------------------------------

# Use LiveReload
activate :livereload

# Use Search Engine Sitemap
set :url_root, data.config.site.root_url
activate :search_engine_sitemap

# User Bower to manage vendor scripts
activate :bower

# Split up each required asset into its own script/style tag instead of combining them
set :debug_assets, true

# --------------------------------------------------------------------------------------------------
# Paths
# --------------------------------------------------------------------------------------------------

set :css_dir,     'stylesheets'
set :fonts_dir,   'fonts'
set :images_dir,  'images'
set :js_dir,      'javascripts'

# Pretty URLs - See https://middlemanapp.com/advanced/pretty_urls/
activate :directory_indexes

# Okay Geeze
# First, we sort the dates hash to be in the correct date order
# Then we do each_with_index to get the idex

trip_dates = data.dates.sort{ |a, b| a.to_s.downcase <=> b.to_s.downcase }

data.dates.sort{ |a, b| a.to_s.downcase <=> b.to_s.downcase }.each_with_index do | (slug,date), index |
  # Replace '-' with '/' in filename
  path = slug.gsub('-', '/')
  
  # Populate prev/next dates
  prev_date = index == 0 ? nil : trip_dates[index - 1]
  next_date = (index + 1) == trip_dates.length ? nil : trip_dates[index + 1]
  proxy "#{path}.html", "/day/template.html", locals: { slug: slug, date: date, index: index, next_date: next_date, prev_date: prev_date }, ignore: true
end

# --------------------------------------------------------------------------------------------------
# Build configuration
# --------------------------------------------------------------------------------------------------

configure :build do
  # Exclude any vendor components (bower or custom builds) in the build
  ignore 'stylesheets/vendor/*'
  ignore 'javascripts/vendor/*'

  activate :autoprefixer do |config|
    config.browsers = ['last 2 versions', 'Explorer >= 9', 'Firefox 15']
    config.cascade  = true
  end

  activate :gzip

  # Minify CSS
  activate :minify_css

  # Minify Javascript
  activate :minify_javascript

  # Minify HTML
  activate :minify_html, remove_http_protocol: false,
                         remove_https_protocol: false,
                         remove_input_attributes: false,
                         remove_quotes: false

  # Compress images (default)
  require 'middleman-smusher'
  activate :smusher

  # Compress ALL images (advanced)
  # Before activating the below, follow setup instructions on https://github.com/toy/image_optim
  # activate :imageoptim do |options|
  #   options.pngout = false # set to true when pngout is also installed
  # end

  # Uniquely-named assets (cache buster)
  # Exception: svg & png in images folder because they need to be interchangeable by JS
  activate :asset_hash, ignore: [%r{images/(.*\.png|.*\.svg)$}i]

  activate :build_cleaner
end
