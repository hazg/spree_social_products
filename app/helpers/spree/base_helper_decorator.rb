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
      escape absolute_image_url(image.attachment.url)
    end

    def absolute_image_url(url)
      URI.join(request.url, url).to_s
    end

    def twitter_text(product)
      "#{product.name} Description: #{truncate(product.description, length: 50)} Get it Here - #{spree.product_url(product)} "
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
  end
end
