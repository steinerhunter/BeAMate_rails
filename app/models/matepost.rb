class Matepost < ActiveRecord::Base
  attr_accessible :content, :flying_to, :flying_from, :departing_on, :returning_on
  belongs_to :user

  validates :user_id, :presence => true
  validates :flying_to, :presence => { :message => "OOPS! Looks like you didn't tell us where you were flying to..."}
  validates :flying_from, :presence => { :message => "OOPS! Looks like you didn't tell us where you were flying from..."}
  validates :departing_on, :presence => { :message => "OOPS! Looks like you didn't tell us when you were departing..."}
  validates :returning_on, :presence =>  { :message => "OOPS! Looks like you didn't tell us when you were returning..."}
  validate :depart_in_past
  validate :return_after_depart
  validates :content, :presence => { :message => "OOPS! Looks like you didn't tell us a bit more details..."}
  validates :content, :length => { maximum: 140 , :message => "OOPS! Looks like you wrote a bit too much..."}


  default_scope order: 'mateposts.created_at DESC'

  private

  def depart_in_past
    if self.departing_on.past?
      errors.add :departing_on, "OOPS! It seems your departing date is in the past..."
    end
  end

  def return_after_depart
    if self.departing_on > self.returning_on
      errors.add :returning_on, "OOPS! It seems like you're coming back before even going there..."
    end
  end

end
