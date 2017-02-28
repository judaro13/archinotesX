class Datasource
  include Mongoid::Document

  field :host, type: String
  field :custom_name, type: String
  field :db_type, type: String, default: "sql"
  field :db_name, type: String
  field :username, type: String
  field :password, type: String
  field :port, type: String
  field :tables, type: Array, default: []
  field :state, type: Boolean, default: false

  has_many :data_microservices

  validates_presence_of :host, :db_name, :username, :password, :port, :custom_name
  validates_uniqueness_of :custom_name

  before_save :set_tables

  def db_url
    "postgres://#{username}:#{password}@#{host}:#{port}/#{db_name}"
  end

  def connection
    PG::Connection.new( dbname: self.db_name,
      port: self.port,
      host: self.host,
      user: self.username,
      password: self.password,
      connect_timeout: 200
    )
  rescue
    false
  end

  def test_connection
    conn = connection
    if conn
      conn.close
      true
    else
      false
    end
  end

  private
  def set_tables
    if conn = connection
      temp = []
      res  = conn.exec("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';")
      res.each do |t|
        name = t["table_name"]
        next if name.start_with?("pg_")
        temp << name
      end

      conn.close

      self.tables = temp
      self.state = true
    end
  end

end
