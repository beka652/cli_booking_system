require "securerandom"

class IDGenerator
  @generator = securerandom
  @id_length = 2

  def self.generate_user_id
    "user/#{@generator.hex(@id_length)}/#{Date.today.year}"
  end

  def self.generate_resource_id
    "resource/#{@generator.hex(@id_length)}/#{Date.today.year}"
  end

  def self.generate_booking_id
    "booking/#{@generator.hex(@id_length)}/#{Date.today.year}"
  end

end
