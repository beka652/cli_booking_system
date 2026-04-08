require_relative "./controllers/booking_manager"


# accepted commands
#  -> ruby app.rb -list [users | resources | bookings]
# -> ruby app.rb -create user
# -> ruby app.rb -make booking
# -> ruby app.rb -cancel booking
# -> ruby app.rb -add resource
# also commands are case-sensitive (all commands must be in lower-case).

class Console
  @booking_manager ||=BookingManager.new



  def self.execute(args=ARGV)
    command = args.join " "
    case command
    when "-list users", "-list resources", "-list bookings" # done
      list_ command
    when "-create user" # done
      create_user
    when "-make booking" # done
      make_booking
    when "-cancel booking"
      cancel_booking
    when "-add resource" #
      #do sth
      add_resource
    when  "-help"
      help
    else
      # command not found!!!
    end
  end
  private

  def self.list_ command
    _, list_type = command.split " "
    case list_type
    when "users"
      list_users
    when "resources"
      list_resources
    else
      list_bookings
    end
  end

  def self.list_users
    puts @booking_manager.list_users
  end

  def self.list_resources
    puts @booking_manager.list_resources
  end

  def self.list_bookings
    puts @booking_manager.list_bookings
  end

  def self.create_user
    name = get_name
    role = get_role

    @booking_manager.create_user name: name, role: role
  end

  def self.get_user_name
    while true
      print "Please enter your name: "
      name = STDIN.gets.chomp.strip
      break if is_name_valid (name)
      puts "Incorrect name. Please enter a valid name!!!"
    end
    return name
  end

  def self.get_user_role
    while true
      print "Please enter your role: "
      role = STDIN.gets.chomp.strip
      break if is_role_valid role
      puts "Incorrect role. Please enter a valid role"
    end
    return role
  end

  def self.is_name_valid name
    name_pattern = /^([a-zA-Z ]{2,50})$/
    if name_pattern.match? name
      return true
    else
      false
    end
  end

  def self.is_role_valid role
    role_pattern = /^([a-zA-Z ]{2,50})$/
    if role_pattern.match? role
      return true
    else
      return false
    end
  end

  def self.add_resource
    name = get_resource_name
    category = get_resource_category
    @booking_manager.add_resource name: name , category: category
  end

  def self.get_resource_name
    while true
      print "Please enter resource name: "
      name = STDIN.gets.chomp.strip
      break if is_name_valid (name)
      puts "Incorrect name. Please enter a valid name!!!"
    end
    return name
  end

  def self.get_resource_category
    while true
      print "Please enter its category: "
      category = STDIN.gets.chomp.strip
      break if is_role_valid category
      puts "Incorrect role. Please enter a valid category"
    end
    return category
  end

  def self.make_booking

    print  "Enter user id: "
    user_id = STDIN.gets.chomp.strip

    user = @booking_manager.get_user(user_id)

    if user.nil?
      puts "Invalid user!!!"
    elsif not (["assitant", "student"].include? user.role.downcase )
      puts "Sorry only assistant and student can create booking"
    else
      print "Enter resource id: "
      resource_id = STDIN.gets.chomp.strip

      if @booking_manager.resource_exist? resource_id
        starting_date = get_starting_date
        ending_date = get_ending_date

        if @booking_manager.make_booking(user_id, resource_id, starting_date, ending_date)
          puts "Resources booked successfully"
        else
          puts "Cannot currently create booking. (Date range occupied or conflicting)"
        end
      else
         puts "Invalid resouce id"
      end
    end
  end

  def self.get_starting_date
    while true
      print  "Enter starting date: (yyyy-mm-dd) "
      starting_date = STDIN.gets.chomp.strip
      break if is_valid_date(starting_date)
      puts  "Invalid date"
    end
    return starting_date
  end

  def self.get_ending_date
    while true
      print "Enter ending date: (yyyy-mm-dd) "
      ending_date = STDIN.gets.chomp.strip
      break if is_valid_date(ending_date)
      puts  "Invalid date"
    end
    return ending_date
  end

  def self.is_valid_date(date)
    ymd = date.split("-")
    if ymd.length != 3
      return false
    elsif  ymd[0].length != 4 || ymd[1].length != 2 || ymd[2].length != 2
      return false
    elsif not (ymd[0].match(/\A\d+\z/) && ymd[1].match(/\A\d+\z/) && ymd[2].match(/\A\d+\z/) )
      return false
    else
      return true
    end
  end

  def self.cancel_booking
    print "Enter booking id: "
    id = STDIN.gets.chomp.strip

    if @booking_manager.booking_exist? id
      if @booking_manager.cancel_booking id
       puts  "Booking cancelled successfully"
      else
        puts "Booking already cancelled!!!"
      end
    else
      print "Incorrect booking id"
    end
  end

  def self.help
    puts <<~HELP
                ____________________
                # accepted commands #
                ---------------------

    # -> ruby app.rb -list [users | resources | bookings]
    # -> ruby app.rb -create user
    # -> ruby app.rb -make booking
    # -> ruby app.rb -cancel booking
    # -> ruby app.rb -add resource

      # !!!  Note: all  commands are case-sensitive (all commands must be in lower-case). !!!
    HELP
  end
end




Console.execute
