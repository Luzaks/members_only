class User < ApplicationRecord
  
  before_create :remember_t
  has_secure_password

  class << self

    def new_token
      SecureRandom.urlsafe_base64 
    end

    def digest(token)
      Digest::SHA1.hexdigest(token.to_s)
    end
    
  end

  private

  def remember_t
    self.remember_token = User.digest(User.new_token)
  end

end
