Time.zone = "UTC"

set :url_root, 'https://betta.io'

activate :blog do |blog|
  blog.prefix = "blog"

  blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.taglink = "categories/{tag}.html"
  blog.layout = "article"
  blog.summary_separator = /<!-- more -->/
  blog.summary_length = 250
  blog.year_link = "{year}.html"
  blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 5
  # blog.page_link = "page/{num}"
end

page "/atom.xml", layout: false

set :markdown_engine, :redcarpet
set :markdown, :fenced_code_blocks => true, :smartypants => true

activate :search_engine_sitemap

helpers do
  def description
    if current_page.data.description
      current_page.data.description
    elsif current_page.try(:summary)
      Nokogiri::HTML(current_page.summary).text.split(" ").join(" ")[0..140]+'...'
    elsif !current_page.data.default_description
      Nokogiri::HTML(page_articles.first.summary).text.split(" ").join(" ")
    else
      "Cristiano Betta - Senior Developer Advocate @ Braintree and PayPal"
    end
  end

  def root?
    current_page.path == 'index.html'
  end
end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

activate :livereload
activate :directory_indexes
activate :syntax
activate :inliner

activate :disqus do |d|
  d.shortname = 'bettacoding'
end

activate :deploy do |deploy|
  deploy.method = :git
  deploy.remote = "origin"
  deploy.branch = "master"
  deploy.strategy = :force_push
  deploy.build_before = true
end

activate :cloudfront do |cf|
  cf.access_key_id = 'AKIAJ23SPLRICBEYI62A'
  cf.secret_access_key = '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'
  cf.distribution_id = 'E1MEX2ODNT3S93'
end

activate :google_analytics do |ga|
  ga.tracking_id = 'UA-2925354-7'
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :layout, 'default'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
  # activate :relative_assets
end
