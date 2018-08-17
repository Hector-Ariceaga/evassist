class User < ActiveRecord::Base
  has_many :events
  has_many :tasks, through: :events
  has_secure_password

  def slug
    self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    self.all.find {|instance| instance.slug == slug}
  end

end
