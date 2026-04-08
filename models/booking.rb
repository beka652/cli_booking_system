require "securerandom"
require "sqlite3"
requie "date"

class Booking
  @title = "Bookings"
  @db ||= SQLite3::Database.new "booking_system.db"
  #======= create bookings table if it doesn't exist
  @db.execute <<~SQL
  CREATE TABLE IF NOT EXISTS bookings (
      id TEXT PRMIARY KEY,
      user_id TEXT NOT NULL,
      resource_id TEXT NOT NULL,
      start_date TEXT NOT NULL,
      end_date TEXT NOT NULL,
      status TEXT NOT NULL,
      FOREIGN KEY (user_id) REFERENCES users (id),
      FOREIGN KEY (resource_id) REFERENCES resources (id)
  );
  SQL
  # =============================================

  def self.get_all_bookings
    result = @db.execute2("SELECT * FROM bookings")
    return {
      title: @title,
      headings:result.delete_at(0),
      rows:result
    }
  end

  def self.make_booking(user_id, resource_id, starting_date, ending_date)
    result = @db.execute("SELECT * FROM bookings WHERE resource_id=#{resource_id}")
    if !(result.empty?)
      result.each do |row|
        return false if conflict_exist? row, starting_date, ending_date
      end
    else
      id = IDGenerator.generate_booking_id
      result = @db.execute("SELECT * FROM bookings WHERE id = \"#{id}\"")

      until result.empty?
        id = IDGenerator.generate_booking_id
        result = @db.execute("SELECT * FROM bookings WHERE id = #{id}")
      end

      @db.execute("INSERT INTO bookings (id, user_id, resource_id, start_date, end_date, status) VALUES (?, ?, ?, ?, ?, ?)",
        [id, user_id, resource_id, starting_date, ending_date, "ACTIVE"])
      return true
    end
  end

  def self.conflict_exist?(row, starting_date, ending_date)
    row_start_date = Date.parse(row[3])
    row_end_date = Date.parse(row[4])

    new_start_date = Date.parse(startng_date)
    new_end_date = Date.parse(ending_date)

    if new_end_date < row_start_date &&
     row_end_date < new_start_date
     return false
    else
      return true
  end

  end


end
