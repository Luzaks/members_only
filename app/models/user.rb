class User < ApplicationRecord
  has_many :posts
  before_create :remember_t
  has_secure_password

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    def authenticated?(remember_token)
      BCrypt::Password.new(remember_token).is_password?(remember_token)
    end
  end

  def forget
    update_attribute(:remember_token, nil)
  end

  private

  def remember_t
    self.remember_token = User.digest(User.new_token)
  end
end
