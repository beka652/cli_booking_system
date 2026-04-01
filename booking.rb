class Booking
  def intialize(user, resource)
    create_booking(user,resource)
    @user = user
    @resource = resource
  end
  def create_booking
    if resource.avail
      resource.avail=false
    else
      raise "Resource already taken!!!"
    end
  end
  def cancel_booking
  end
end
