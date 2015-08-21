class Client
  attr_reader :id, :name, :stylist_id

  def initialize(attributes)
    @id = attributes[:id].to_i
    @name = attributes[:name]
    @stylist_id = attributes[:stylist_id].to_i
  end

  def self.all
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients;")
    returned_clients.each do |client|
      name = client['name']
      id = client['id'].to_i
      stylist_id = client['stylist_id'].to_i
      clients.push(Client.new({ id: id, name: name, stylist_id: stylist_id }))
    end
    clients
  end

  def save
    result = DB.exec("INSERT INTO clients (name, stylist_id) VALUES ('#{self.name}', #{self.stylist_id}) RETURNING id;")
    @id = result.first.fetch('id').to_i
  end

  def ==(client)
    self.id == client.id && self.name == client.name && self.stylist_id == client.stylist_id
  end

  def self.find(client_id)
    found_client = nil
    returned_client = DB.exec("SELECT * FROM clients WHERE id = #{client_id};")
    returned_client.each do |client|
      name = client['name']
      id = client['id'].to_i
      stylist_id = client['stylist_id'].to_i
      found_client = Client.new({ name: name, id: id, stylist_id: stylist_id })
    end
    found_client
  end

  def update(attributes)

    if attributes[:stylist_id]
      @stylist_id = attributes[:stylist_id].to_i
      DB.exec("UPDATE clients SET stylist_id = #{@stylist_id};")
    end

    @name = attributes[:name]
    DB.exec("UPDATE clients SET name = '#{name}';")


  end
end
