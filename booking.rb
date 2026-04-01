require "securerandom"

class Booking
  attr_reader :user, :resource, :status, :created_at, :id
  def initialize(user, resource)
    # a new booking is only  created if the given resource isn't taken by another user
    if resource.avail
      @id = "book/#{SecureRandom.uuid[0,7]}"
      @user = user
      @resource = resource
      @status = "active"
      @created_at = Time.now
      resource.avail=false
    else
      raise "Resource already taken!"
    end
  end
  def cancel
    @status="cancelled"
    @resource.avail=true
  end
end
