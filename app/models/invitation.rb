class Invitation < ActiveRecord::Base
  attr_accessible :recipient_email

  belongs_to :sender, :class_name => 'User'
  has_one :recipient, :class_name => 'User'

  validates :recipient_email, :presence => { :message => "OOPS! We're going to need an email address here..."}
  validates :recipient_email, :format => { :with => %r{.+@.+\..+}, :message => "OOPS! Email address should be like 'user@example.com'..." }, :allow_blank => true
  validate :recipient_is_not_registered
  validate :recipient_has_already_asked

  before_create :generate_token

  private

  def recipient_is_not_registered
    errors.add :recipient_email, "OOPS! It seems this email address is already in our records..."if User.find_by_email(recipient_email)
  end

  def recipient_has_already_asked
    errors.add :recipient_email, "OOPS! It seems a request has already been made using this email address..."if Invitation.find_by_recipient_email(recipient_email)
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

end
