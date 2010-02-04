module SchoolsHelper
  
  def render_chart(school,size="280")
    image_tag(radar_chart_school_path(school, :time => ENV["RAILS_ENV"] == "development" ? Time.now.to_s(:number) : nil))
  end
  
end
