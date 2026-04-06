require_relative "../models/booking"
require_relative "../models/resource"
require_relative "../models/user"

class BookingManager
  def initialize(console)
    @console = console
    @booking_model = Booking
    @resource_model = Resource
    @user_model = User
  end

  def list_users
    users = User.get_all_users
    console.print_users
  end
  def list_resources
  end
  def list_bookings
  end
  def create_user
  end
  def add_resource
  end
  def make_booking
  end
  def cancel_booking
  end
end
