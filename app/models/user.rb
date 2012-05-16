class MailAddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << (options[:message] || "is not an email") unless
      value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  end
end
class User < ActiveRecord::Base
  acts_as_paranoid

  # Include default devise modules. Others available are:
  include ActiveModel::Validations

  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :status, :deleted_at

  before_create :reset_param

  def reset_param
    self.status = 'active'
  end
  # attr_accessible :title, :body
  validates :email, :presence => true, :mail_address => true
end
