require_relative "./booking"
require_relative "./resource"
require_relative "./booking"

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
    4.List available resources
    5.List bookings
    6.List users
    7.quit

    Enter number: )

    while true
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
        list_available_resources
      when "5"
        list_bookings
      when "6"
        list_users
      when "7"
        exit
      else
        raise "Unkown command: #{choice}"
      end
    end


  end

  def make_booking
    puts "Make booking"
    # Get the resource id first
    print "Enter Resource id: "
    resource_id = get.chomp.strip
    resource = @resource_container[resource_id]

    # only proceed if the resource exists
    if resource
      # get the user id
      print "Enter user id: "
      user_id = gets.chomp.strip
      user = @user_container[user_id]
      # only proceed if the user is available
      if user
        booking = Booking.new(user, resource)
        @booking_container[booking.id] = booking
      end
    end
  end




  def cancel_booking
    puts "Cancel Booking"
    print "Enter Booking id: "
    booking_id = get.chomp.strip
    booking = @booking_container[booking_id]
    if booking
      booking.cancel
    else
      raise "Booking don't exist"
    end
  end



  def add_resource
    puts "Add resource"
    print "Enter resouce id: "
    id = get.chomp.strip
    print "Enter resource name: "
    name = get.chomp.strip
    print "Enter resource category: "
    category = get.chomp.strip

    resource = Resource.new(id, name , category)
    @resource_container[id] = resource
  end

  def list_available_resources
    puts "id-----------name----------category"
    @resource_container.each do |key, value|
      puts "#{id} -------- #{value.name} ------- #{value.category}"
    end
  end
  def list_bookings
    puts "id------user----resource-----status----created_at"
    @resource_container.each do |key, value|
      puts "#{id} -------- #{value.user.name} ------- #{value.resource.name}-------#{value.status}------#{value.created}"
    end
  end
  def list_users
  end

end


Main.new
