class Stylist
  attr_reader :id, :name

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
  end

  def self.all
    stylists = []
    returned_stylists = DB.exec('SELECT * FROM stylists;')
    returned_stylists.each do |stylist|
      name = stylist['name']
      id = stylist['id'].to_i
      stylists.push(Stylist.new({id: id, name: name}))
    end
    stylists
  end

  def save
    result = DB.exec("INSERT INTO stylists (name) VALUES ('#{self.name}') RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def ==(stylist)
    self.id == stylist.id && self.name == stylist.name
  end

  def self.find(stylist_id)
    found_stylist = nil
    returned_stylist = DB.exec("SELECT * FROM stylists WHERE id = #{stylist_id};")
    returned_stylist.each do |stylist|
      id = stylist['id']
      name = stylist['name']
      found_stylist = Stylist.new({ id: id, name: name })
    end
    found_stylist
  end

  def update(attributes)
    @name = attributes[:name]

    DB.exec("UPDATE stylists SET name = '#{@name}' WHERE id = #{self.id};");
  end

  def destroy
    DB.exec("DELETE FROM stylists WHERE id = #{self.id};")
  end

  def clients
    clients =[]
    returned_clients = DB.exec("SELECT * FROM clients WHERE stylist_id = #{self.id};")
    returned_clients.each do |client|
      name = client['name']
      id = client['id'].to_i
      stylist_id = client['stylist_id'].to_i
      clients.push(Client.new({ name: name, id: id, stylist_id: stylist_id }))
    end
    clients
  end


end
