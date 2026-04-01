require_relative "booking"

class Main

  def initialize()
    @resource_container = {} # store all resource creating during the runtime of this program
    @booking_container = {} # contains all booking made during a single runtime
    @user_container = {} # contains all users created using during a single runtime
    menu
  end

  def menu
    options = %Q(
    1.Make Booking
    2.Cancel Booking
    3.Add Resource
    4.Remove Resource
    5.quit

    Enter number:
    )

    while false
      print options
      choice = gets.chomp.strip

      case choice
      when  "1"
         make_booking
      when "2"
        cancel_booking
      when "3"
        add_resource
      when "4"
        remove_resource
      when  "5"
        exit
      else
        raise "Unkown command: #{choice}"
      end
      end

    end

  end

end
