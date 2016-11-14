class User < ActiveRecord::Base
  belongs_to :department
  has_many :assets

  validates_confirmation_of :password
  attr_accessor             :password_confirmation

  def self.authenticate(code, password)
    usr = find_by(code: code)
    if usr != nil && usr.password == password then
      usr
    else
      return
    end
  end
end
