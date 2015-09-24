Time.zone = "UTC"

set :url_root, 'https://betta.io'
set :site_title, 'Cristiano Betta - Senior Developer Advocate @ Braintree and PayPal'

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
      Nokogiri::HTML(current_page.summary).text.split(" ").join(" ")
    elsif !current_page.data.default_description
      Nokogiri::HTML(page_articles.first.summary).text.split(" ").join(" ")
    else
      site_title
    end
  end

  def title
    title = ""
    title += current_article.title unless current_article.nil?
    title
  end

  def image
    if current_page.data.image
      url_root+image_path(current_page.data.image)
    else
      url_root+image_path('cbetta.jpg')
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


activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'bettaio'
  s3_sync.region                     = 'eu-central-1'
  s3_sync.aws_access_key_id          = 'AKIAI7MLWZX43LYE2ILA'
  s3_sync.aws_secret_access_key      = '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'
end

activate :cloudfront do |cf|
  cf.access_key_id = 'AKIAI7MLWZX43LYE2ILA'
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
