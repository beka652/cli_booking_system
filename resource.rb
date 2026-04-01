class Resource
  # resouce objects have additional avail attribute that show if they are taken or not
  attr_accessor :id , :name, :category, :avail
  def intialize(id, name , category)
    @id = id
    @name = name
    @category = category
    @avail = true
  end
end
