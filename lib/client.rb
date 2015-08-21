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
      stylist_id = client['stylist_id'].to_id
      clients.push(Client.new({ id: id, name: name, stylist_id: stylist_id }))
    end
    clients
  end
end
