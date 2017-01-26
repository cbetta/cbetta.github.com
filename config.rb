Time.zone = "London"

set :url_root, 'https://betta.io'

activate :blog do |blog|
  blog.prefix = "blog"

  blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.taglink = "categories/{tag}.html"
  blog.layout = "article"
  blog.summary_separator = /\[MORE\]/
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

data.galleries.each do |path, value|
  proxy "/galleries/#{path}", "/gallery.html", :locals => { :gallery => path }
end

ignore "/gallery.html"
page "/atom.xml", layout: false

set :markdown_engine, :kramdown
set :markdown, fenced_code_blocks: true, smartypants: true, parse_block_html: false

activate :search_engine_sitemap

helpers do
  def dx_image group, id, title, extension = 'png'
    url = "/images/dx/#{group}/#{group}-#{id}.#{extension}"
    image = "![#{title}](/images/dx/lazy.png){:.ui.image.fluid.bordered.lazy data-src=\"#{url}\"}"
    "[#{image}](#{url}){: data-lightbox=\"lightbox\" data-title=\"#{title}\"}"
  end

  def slide_image group, id
    url = "/images/slides/#{group}/#{group}.#{"%03d" % id}.jpeg"
    image = "![#{title}](/images/dx/lazy.png){:.ui.image.fluid.bordered.lazy data-src=\"#{url}\"}"
    "[#{image}](#{url}){: data-lightbox=\"lightbox\" data-title=\"#{title}\"}"
  end

  def active(uri, exact = false)
    if exact
      return "active" if current_page.url == uri
    else
      return "active" if current_page.url.index(uri) == 0
    end
    nil
  end

  def description
    if current_page.data.description
      current_page.data.description
    elsif current_page.try(:summary)
      Nokogiri::HTML(current_page.summary).text.split(" ").join(" ")
    elsif !current_page.data.default_description
      Nokogiri::HTML(page_articles.first.summary).text.split(" ").join(" ")
    else
      data.site.title
    end
  end

  def title
    return (current_page.data.title + " - ") if current_page.data.title
    title = ""
    title += (current_article.title + " - ") unless current_article.nil?
    title
  end

  def image
    if current_page.data.image
      data.site.root+image_path(current_page.data.image)
    else
      data.site.root+image_path('cbetta.jpg')
    end
  end
end

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes
activate :sprockets

activate :livereload, js_host: ENV['JS_HOST']
activate :directory_indexes
activate :syntax, line_numbers: true

activate :disqus do |d|
  d.shortname = 'bettacoding'
end

activate :s3_sync do |s3_sync|
  s3_sync.bucket                     = 'bettaio'
  s3_sync.region                     = 'eu-central-1'
  s3_sync.aws_access_key_id          = ENV['BETTA_AWS_KEY']
  s3_sync.aws_secret_access_key      = ENV['BETTA_AWS_SECRET']
end

activate :cloudfront do |cf|
  cf.access_key_id = ENV['BETTA_AWS_KEY']
  cf.secret_access_key = ENV['BETTA_AWS_SECRET']
  cf.distribution_id = 'E1MEX2ODNT3S93'
end

caching_policy 'text/html', max_age: 0, must_revalidate: true
default_caching_policy max_age:(60 * 60 * 24 * 365)

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
  activate :minify_html
  activate :asset_host, host: '//d2vxwsh43haze0.cloudfront.net'
end
