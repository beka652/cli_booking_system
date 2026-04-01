class Booking
  attr_reader :user, :resource, :status, :created_at
  def initialize(user, resource)
    if resource.avail
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
