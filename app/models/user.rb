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

  def system_nil
    if User.where(system: true).count == 0
      errors.add(user.system, "システム管理権限を持つユーザーがいなくなります")
    end
  end

  def admin_nil
    if User.where(admin: true).count == 0
      errors.add(user.admin, "資産管理権限を持つユーザーがいなくなります")
    end
  end

  validate  :system_nil, :admin_nil
  validates :password, presence: true
  validates :code, presence: true
  validates :name, presence: true
  validates :code, uniqueness: true
end
