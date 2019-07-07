module Spree
  BaseHelper.module_eval do
    def pin_it_button(product)
      return if product.images.empty?

      url = escape spree.product_url(product)
      media = absolute_product_image(product.images.first)
      description = escape product.name

      link_to('Pin It',
              "http://pinterest.com/pin/create/button/?url=#{url}&media=#{media}&description=#{description}",
              class: 'pin-it-button',
              'count-layout' => 'none').html_safe
    end

    def absolute_product_image(image)
      #escape absolute_image_url(
        #image.attachment.url
        Rails.application.routes.url_helpers.url_for(image.url(:large))
      #)
    end

    def absolute_image_url(url)
      URI.join(request.url, url).to_s
    end

    def twitter_text(product)
      values = {
        product_text: "#{product.name} #{product.description}",
        product_link: spree.product_url(product),
        get_it_here: "Get It Here -",
        twitter_limit: 280
      }

      get_twitter_text(values)
    end

    def social_media_share_allowed?
      Spree::Social::Config.social_services.any? { |service| Spree::Social::Config.send "preferred_#{service}_button".to_sym }
    end

    def reddit_text(product)
      if product.images.present?
        "#{product.description} [Image] (#{absolute_image_url(product.images.first.attachment.url)}) [Get It Here] (#{spree.product_url(product)})"
      else
        "#{product.description} [Get It Here] (#{spree.product_url(product)})"
      end
    end

    private

    def escape(string)
      URI.escape string, /[^#{URI::PATTERN::UNRESERVED}]/
    end

    def get_twitter_text(values)
      remaining_length = values[:twitter_limit] - values[:get_it_here].length - values[:product_link].length - 3 # 3 spaces

      if remaining_length > values[:product_text].length
        "#{values[:product_text]} #{values[:get_it_here]} #{values[:product_link]}"
      else
        "#{truncate(values[:product_text], length: remaining_length)} #{values[:get_it_here]} #{values[:product_link]}"
      end
    end
  end
end
