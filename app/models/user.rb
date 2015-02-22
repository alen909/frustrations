class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_secure_password unless: :oauth_token
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, unless: :oauth_token
  
  #validates :password, presence: true, unless: :oauth_token     #ne radi

  has_many :frustrations, :dependent => :destroy #:)


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = ('a'..'z').to_a.shuffle[0,16].join
      user.avatar = auth.info.image
      user.town = auth.info.location
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end