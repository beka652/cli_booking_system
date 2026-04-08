require_relative "../models/booking"
require_relative "../models/resource"
require_relative "../models/user"
require "terminal-table"

class BookingManager
  def initialize(console)
    @console = console
    @booking_model = Booking
    @resource_model = Resource
    @user_model = User
  end

  def get_user(user_id)
    @user_model.get_user(user_id)
  end

  def resource_exist?(resouce_id)
    @resource_model.resource_exist?(resouce_id)
  end

  def list_users
    users = @user_model.get_all_users
    return  Terminal::Table.new title: users[:title], headings: users[:headings], rows: users[:rows]
  end
  def list_resources
    resources = @resource_model.get_all_resources
    return Terminal::Table.new title: resources[:title], headings: resources[:headings], rows: resources[:rows]
  end
  def list_bookings
    bookings = @booking_model.get_all_bookings
    return Terminal::Table.new title:bookings[:title], headings: bookings[:headings], rows: bookings[:rows]
  end
  def create_user name:, role:
    @user_model.create_user name: , role:
  end
  def add_resource name:, category:
    @resource_model.add_resource name:, category:
  end
  def make_booking(user_id, resource_id, starting_date, ending_date)
    @booking_model.make_booking(user_id, resource_id, starting_date, ending_date)
  end
  def cancel_booking id
    @booking_model.cancel_booking id
  end

  def booking_exist? id
    @booking_model.booking_exist? id
  end
end
