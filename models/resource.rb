require "sqlite3"

class Resource
  @title = "Resources"
  @db ||= SQLite3::Database.new "booking_system.db"
  #======== create resources table if it doesn't exist
  @db.execute <<~SQL
  CREATE TABLE IF NOT EXISTS resources (
      id TEXT  PRIMARY KEY,
      name TEXT NOT NULL,
      category TEXT NOT NULL
  );
  SQL
  # =============================================


  def self.get_all_resources
    result = @db.execute2 ("SELECT * FROM resources")

    hash_result = {
      title: @title,
      headings: result.delete_at(0),
      rows: result
    }
  end
end
