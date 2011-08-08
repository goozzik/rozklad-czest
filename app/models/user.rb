# coding: utf-8
class User < ActiveRecord::Base

  has_many :favourites
  attr_accessible :user_name, :password, :password_confirmation
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password, :message => "Podane hasła nie zgadzają się."
  validates_presence_of :password, :on => :create, :message => "Wypełnij pole Hasło."
  validates_presence_of :user_name, :message => "Wypełnij pole Login."
  validates_uniqueness_of :user_name, :message => "Użytkownik o podanym loginie już istnieje."
  
  def self.authenticate(user_name, password)
    user = find_by_user_name(user_name)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def self.authenticated_with_token(user_id, password_salt)
    user = find(id)
    user && user.password_salt == password_salt ? user : nil
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
