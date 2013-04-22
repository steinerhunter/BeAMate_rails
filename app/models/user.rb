# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :invitation_token
  has_secure_password
  acts_as_messageable
  has_many :requestposts, dependent: :destroy
  has_many :mateposts, dependent: :destroy
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  belongs_to :invitation

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, :presence => { :message => "OOPS! Looks like you didn't tell us your name..."}
  validates :name, :length => { maximum: 30 , :message => "OOPS! Your name seems a bit too long..."}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => { :message => "OOPS! We're going to need your email address..."}
  validates :email, :format => { with: VALID_EMAIL_REGEX, :message => "OOPS! Email address should be like 'user@example.com'..." }
  validates :email, :uniqueness => { case_sensitive: false, :message => "OOPS! Looks like someone has already registered with this address..." }

  validates :password, :presence => { :message => "OOPS! Looks like you didn't pick a password..."}
  validates :password, :length => { minimum: 8, :message => "OOPS! Looks like your password is a bit too short..."}
  validates :password_confirmation, :presence => { :message => "OOPS! Looks like you didn't confirm your password..."}

  validates :invitation_id, :presence => { :message => "OOPS! Sorry, we cannot sign you up without an invitation..."}, on: :create
  validates :invitation_id, :uniqueness => { :message => "OOPS! Looks like someone has already registered with this invitation..." }, on: :create

  LEVEL_2_POINTS = 500
  LEVEL_3_POINTS = 1000
  LEVEL_4_POINTS = 2000
  LEVEL_5_POINTS = 4000
  LEVEL_6_POINTS = 7000

  def user_request_feed
    Requestpost.where("user_id = ?", id)
  end

  def user_mate_feed
    Matepost.where("user_id = ?", id)
  end

  def request_feed
    Requestpost.all
  end

  def mate_feed
    Matepost.all
  end

  def mailboxer_email(message)
    email
  end

  def invitation_token
    invitation.token if invitation
  end

  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    PasswordResetsMailer.password_reset(self).deliver
  end

  def add_mate_points(num_to_add)
    self.update_attribute(:mate_points, self.mate_points + num_to_add)
    if (((self.mate_points >= LEVEL_2_POINTS) && (self.mate_level == 1)) ||
           ((self.mate_points >= LEVEL_3_POINTS) && (self.mate_level == 2)) ||
           ((self.mate_points >= LEVEL_4_POINTS) && (self.mate_level == 3)) ||
           ((self.mate_points >= LEVEL_5_POINTS) && (self.mate_level == 4)) ||
           ((self.mate_points >= LEVEL_6_POINTS) && (self.mate_level == 5)) )
      self.level_up
    end
  end

  def subtract_mate_points(num_to_subtract)
    if (self.mate_points - num_to_subtract < 0)
      self.update_attribute(:mate_points, 0)
    else
      self.update_attribute(:mate_points, self.mate_points - num_to_subtract)
    end
  end

  def level_up
    self.update_attribute(:mate_level, self.mate_level + 1)
  end

  def level_down
    self.update_attribute(:mate_level, self.mate_level - 1)
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
