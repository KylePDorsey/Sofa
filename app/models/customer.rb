class Customer < ActiveRecord::Base
	has_many :purchases

	  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def self.authenticate(email, password)
    user_to_authenticate = User.find_by(email: email)
    if user_to_authenticate
      return user_to_authenticate if user_to_authenticate.password == password
    end
    nil
  end
end
