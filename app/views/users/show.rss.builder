xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title 'Obserwowane szkoły'
    xml.link followed_schools_url
    
    for movie in @movies
      xml.item do
        xml.title movie.name
        xml.description image_tag(movie.thumb.url)
        xml.pubDate movie.created_at.to_s(:rfc822)
        xml.link school_movie_url(:school_id => movie.school_id, :id => movie)
        xml.guid school_movie_url(:school_id => movie.school_id, :id => movie)
      end
      
    end
    
    for picture in @pictures
      xml.item do
        xml.title picture.name
        xml.description image_tag(picture.url(:thumb))
        xml.pubDate picture.created_at.to_s(:rfc822)
        xml.link school_picture_url(:school_id => picture.school_id, :id => picture)
        xml.guid school_picture_url(:school_id => picture.school_id, :id => picture)
      end
    end
    
    for story in @stories
      xml.item do
        xml.title "##{story.id}"
        xml.description story.body
        xml.pubDate story.created_at.to_s(:rfc822)
        xml.link school_story_url(:school_id => story.school_id, :id => story)
        xml.guid school_story_url(:school_id => story.school_id, :id => story)
      end
    end
  end
end