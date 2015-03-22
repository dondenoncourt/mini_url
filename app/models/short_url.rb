class ShortUrl < ActiveRecord::Base
  validates :url, uniqueness: { case_sensitive: false }
  before_create :set_mini_url

  def self.url_for(mini_url)
    mini_url =  ShortUrl.replace_char_alts(mini_url)
    ShortUrl.where(mini_url: mini_url.downcase).first
  end

  def mini_url
    self[:mini_url] + self[:url][/\.\w*/]
  end

private

  CHAR_ALT = {'0'=>'o', '6'=>'b', '1'=>'l'}
  BAD_WORDS = ['foo', 'bar']

  def set_mini_url
    loop do

      self.mini_url = ShortUrl.replace_char_alts(SecureRandom.urlsafe_base64(6).downcase)

      next  if !ShortUrl.is_sparse?(self.mini_url)

      break if !ShortUrl.exists?(mini_url: self.mini_url)
    end
  end

  def self.is_sparse?(mini_url)
    0.upto(mini_url.size).each do |i|
      search = mini_url.downcase
      search[i] = '_'
      return false if ShortUrl.exists?(["mini_url LIKE '#{search}'"])
    end
    true
  end

  # prevent transcription errors by always using the character version
  def self.replace_char_alts(mini_url)
    CHAR_ALT.each{|k,v| mini_url.gsub!(k,v)}
    mini_url
  end

  def self.has_bad_words?(mini_url)
    BAD_WORDS.each do |bleep|
      return true if mini_url[/#{bleep}/]
    end
    false
  end

  def mini_url=(val)
    write_attribute :mini_url, val
  end
end
