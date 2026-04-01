class Resource
  attr_accessor :id , :name, :category, :avail
  def intialize(id, name , category)
    @id = id
    @name = name
    @category = category
    @avail = true
  end
end
