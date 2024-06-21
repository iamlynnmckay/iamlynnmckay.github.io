# frozen_string_literal: true

require_relative 'type'

module My
  module HTML
    module Resource
      class Iframe < My::Html::Resource::Type
        def self.as_html(
          from: nil,
          srcdoc: nil,
          name: nil,
          width: nil,
          height: nil,
          allowfullscreen: true,
          sandbox: nil,
          loading: nil,
          referrerpolicy: 'strict-origin-when-cross-origin',
          allow: 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share',
          csp: nil,
          title: nil,
          allowpaymentrequest: nil,
          **
        )
          src = case from
                when %r{\Ahttps?://(www\.)?youtube\.com/watch\?v=([\w-]+)\z}
                  video_id = from.match(/v=([\w-]+)/)[1]
                  "https://www.youtube.com/embed/#{video_id}"
                when %r{\Ahttps?://music\.youtube\.com/watch\?v=([\w-]+)\z}
                  video_id = from.match(/v=([\w-]+)/)[1]
                  "https://www.youtube.com/embed/#{video_id}?autoplay=1"
                when %r{\Ahttps?://(www\.)?vimeo\.com/(\d+)\z}
                  video_id = from.match(%r{vimeo\.com/(\d+)})[1]
                  "https://player.vimeo.com/video/#{video_id}"
                when %r{\Ahttps?://(www\.)?instagram\.com/p/([\w-]+)/?\z}
                  post_id = from.match(%r{/p/([\w-]+)})[1]
                  "https://www.instagram.com/p/#{post_id}/embed/"
                when %r{\Ahttps?://(www\.)?twitter\.com/([\w-]+)/status/(\d+)\z}
                  # tweet_id = from.match(/status\/([\d]+)/)[1]
                  "https://twitframe.com/show?url=#{from}"
                when %r{\Ahttps?://(www\.)?facebook\.com/(?:[\w.]+)/posts/(\d+)\z}
                  post_id = from.match(%r{/posts/(\d+)})[1]
                  "https://www.facebook.com/plugins/post.php?href=#{url}&width=500"
                when %r{\Ahttps?://(www\.)?facebook\.com/(?:[\w.]+)/videos/(\d+)\z}
                  video_id = from.match(%r{/videos/(\d+)})[1]
                  "https://www.facebook.com/plugins/video.php?href=#{url}&show_text=0&width=560"
                when %r{\Ahttps?://gist\.github\.com/[\w-]+/(\w+)\z}
                  gist_id = from.match(%r{gist\.github\.com/[\w-]+/(\w+)})[1]
                  "https://gist.github.com/#{gist_id}.js"
                when %r{\Ahttps?://(www\.)?tiktok\.com/@([\w-]+)/video/(\d+)\z}
                  video_id = from.match(%r{/video/(\d+)})[1]
                  "https://www.tiktok.com/embed/#{video_id}"
                when %r{\Ahttps?://(www\.)?dailymotion\.com/video/(\w+)\z}
                  video_id = from.match(%r{/video/(\w+)})[1]
                  "https://www.dailymotion.com/embed/video/#{video_id}"
                when %r{\Ahttps?://(www\.)?soundcloud\.com/([\w-]+/[\w-]+)\z}
                  track_id = from.match(%r{soundcloud\.com/([\w-]+/[\w-]+)})[1]
                  "https://w.soundcloud.com/player/?url=https%3A//soundcloud.com/#{track_id}&color=%23ff5500&auto_play=false&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true&visual=true"
                when %r{\Ahttps?://open\.spotify\.com/(track|album|playlist)/([\w-]+)\z}
                  type, id = from.match(%r{spotify\.com/(track|album|playlist)/([\w-]+)})[1..2]
                  "https://open.spotify.com/embed/#{type}/#{id}"
                when %r{\Ahttps?://(www\.)?pinterest\.com/pin/(\d+)\z}
                  pin_id = from.match(%r{pin/(\d+)})[1]
                  "https://assets.pinterest.com/ext/embed.html?id=#{pin_id}"
                when %r{\Ahttps?://(www\.)?slideshare\.net/([\w-]+/[\w-]+)\z}
                  slide_id = from.match(%r{slideshare\.net/([\w-]+/[\w-]+)})[1]
                  "https://www.slideshare.net/slideshow/embed_code/#{slide_id}"
                when %r{\Ahttps?://(www\.)?tumblr\.com/post/(\d+)\z}
                  post_id = from.match(%r{post/(\d+)})[1]
                  "https://embed.tumblr.com/embed/post/#{post_id}"
                when %r{\Ahttps?://(www\.)?flickr\.com/photos/([\w-]+/\d+)\z}
                  photo_id = from.match(%r{photos/([\w-]+/\d+)})[1]
                  "https://www.flickr.com/photos/#{photo_id}/player/"
                else
                  from
                end

          # Initialize the base string for the iframe element
          element = '<iframe'

          attributes = {
            'src' => src,
            'srcdoc' => srcdoc,
            'name' => name,
            'width' => width,
            'height' => height,
            'allowfullscreen' => allowfullscreen,
            'sandbox' => sandbox,
            'loading' => loading,
            'referrerpolicy' => referrerpolicy,
            'allow' => allow,
            'csp' => csp,
            'title' => title,
            'allowpaymentrequest' => allowpaymentrequest
          }

          # Iterate through the attributes hash and append to the string if the variable is defined
          attributes.each do |attribute, value|
            next if value.nil? || value == false # Skip if value is nil or false

            element += if value == true
                         " #{attribute}"
                       else
                         " #{attribute}=\"#{value}\""
                       end
          end

          # Close the iframe tag
          element += '></iframe>'
        end
      end
    end
  end
end
