class OgpCreator
  require 'mini_magick'

  BASE_IMAGE_PATH = './app/assets/images/ogp_base.jpg'.freeze
  GRAVITY = 'center'.freeze
  TEXT_POSITION = '0,0'.freeze
  FONT = './app/assets/fonts/07LogoTypeGothic7.ttf'.freeze
  FONT_SIZE = 100
  INDENTION_COUNT = 12
  ROW_LIMIT = 8

  def self.build(text)
    text = prepare_text(text)
    image = MiniMagick::Image.open(BASE_IMAGE_PATH)
    image.combine_options do |config|
      config.font FONT
      config.fill 'white'
      config.gravity GRAVITY
      config.pointsize FONT_SIZE
      config.draw "text #{TEXT_POSITION} '#{text}'"
    end
  end

  def self.prepare_text(text)
    text.to_s.scan(/.{1,#{INDENTION_COUNT}}/)[0...ROW_LIMIT].join("\n")
  end
end
