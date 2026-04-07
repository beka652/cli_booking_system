require_relative "./controllers/BookingManager"


# accepted commands
#  -> ruby app.rb -list [users | resources | bookings]
# -> ruby app.rb -create user
# -> ruby app.rb -make booking
# -> ruby app.rb -cancel booking
# -> ruby app.rb -add resource
# also commands are case-sensitive (all commands must be in lower-case).

class Console
  @booking_manager ||=BookingManager.new self

  def self.execute(args=ARGV)
    command = args.join " "

    case command
    when "-list users", "-list resources", "-list bookings"
      _, list_type = command.split " "
      case list_type
      when "users"
        list_users
      when "resources"
        list_resources
      else
        list_bookings
      end

    when "-create user"
      create_user
    when "-make booking"
      # do sth
    when "-cancel booking"
      # do sth
    when "-add resource"
      #do sth
      add_resource
    else
      # command not found!!!
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
    while true
      print "Please enter your name: "
      name = STDIN.gets.chomp.strip
      break if is_name_valid (name)
      puts "Incorrect name. Please enter a valid name!!!"
    end
    while true
      print "Please enter your role: "
      role = STDIN.gets.chomp.strip
      break if is_role_valid role
      puts "Incorrect role. Please enter a valid role"
    end
    @booking_manager.create_user name: name, role: role
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
    while true
      print "Please enter resource name: "
      name = STDIN.gets.chomp.strip
      break if is_name_valid (name)
      puts "Incorrect name. Please enter a valid name!!!"
    end
    while true
      print "Please enter its category: "
      category = STDIN.gets.chomp.strip
      break if is_role_valid category
      puts "Incorrect role. Please enter a valid category"
    end
    @booking_manager.add_resource name: name , category: category
  end

end




Console.execute
