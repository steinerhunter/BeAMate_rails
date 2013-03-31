class Feedback
  attr_accessible :name, :email, :body

  validates :name, :presence => { :message => "OOPS! Looks like you didn't tell us your name..."}
  validates :email, :presence => { :message => "OOPS! We're going to need your email address..."}
  validates :email, :format => { :with => %r{.+@.+\..+}, :message => "OOPS! Email address should be like 'user@example.com'..." }, :allow_blank => true
  validates :body, :presence => { :message => "OOPS! It seems you left out the actual feedback..."}

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end