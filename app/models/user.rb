class User < ActiveRecord::Base
  belongs_to :department
  belongs_to :belong

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

  validates :password, presence: true
  validates :code, presence: true
  validates :name, presence: true
  validates :code, uniqueness: true
end
