class User < ActiveRecord::Base
  has_many :assets
  def self.authenticate(code, password)
    usr = find_by(code: code)
    if usr != nil && usr.password == password then
      usr
    else
      return
    end
  end
end
