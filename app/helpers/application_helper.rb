# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def rss_link(title, path)
    tag :link, :type => 'application/rss+xml', :title => title, :href => path
  end

end
