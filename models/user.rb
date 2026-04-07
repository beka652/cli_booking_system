require "sqlite3"

class User
  @title = "Users"
  @db ||= SQLite3::Database.new "booking_system.db"
  #======== create users table if it doesn't exist
  @db.execute <<~SQL
  CREATE TABLE IF NOT EXISTS users (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      role TEXT NOT NULL
  );
  SQL
  #======= create bookings table if it doesn't exist

  def self.get_all_users
    result = @db.execute2 "SELECT * FROM users"
    # continue tmrw from  here
    hash_result = {
      title: @title,
      headings: result.delete_at(0),
      rows:result
    }
  end
end
