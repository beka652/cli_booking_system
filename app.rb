require_relative "./controllers/BookingManager"


# accepted commands
#  -> ruby app.rb -list [users | resources | bookings]
# -> ruby app.rb -create user
# -> ruby app.rb -make booking
# -> ruby app.rb -cancel booking
# -> ruby app.rb -add resource
# also commands are case-sensitive (all commands must be in lower-case).

command = ARGV.join " "

case command
when "-list users", "-list resources", "-list bookings"
  _, list_type = command.split " "
when "-create user"
  # do sth
when "-make booking"
  # do sth
when "-cancel booking"
  # do sth
when "-add resource"
  #do sth
else
  # command not found!!!
end
