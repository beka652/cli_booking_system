require "securerandom"

class Booking
  attr_reader :id, :user, :resource, :status, :start_date, :end_date

  def initialize(user, resource, start_date, end_date)
    # a new booking is only  created if the given resource isn't taken by another user
    total_reservations = find_all_reseravation_for_resource (resouce)
    if total_reservations.length == 0
      create_reservation(user, resource, start_date, end_date)
    else
      if conflicting_reservations_exist(total_reservations, start_date, end_date)
        raise "Reservation conflict error"
      else
      end
    end
  end


  def cancel
    @status="cancelled"
    @resource.avail=true
  end
end
