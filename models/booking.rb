require "securerandom"
require "sqlite3"

class Booking
  db = SQLite3::Database.new "booking_system.db"
  #======== create users table if it doesn't exist
  db.execute <<~SQL
  CREATE TABLE IF NOT EXISTS users (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      role TEXT NOT NULL
  );
  SQL
  #======== create resources table if it doesn't exist
  db.execute <<~SQL
  CREATE TABLE IF NOT EXISTS resources (
      id TEXT  PRIMARY KEY,
      name TEXT NOT NULL,
      category TEXT NOT NULL
  );
  SQL
  #======= create bookings table if it doesn't exist
  db.execute <<~SQL
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

end
