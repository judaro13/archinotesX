class DataMicroservice < DcosService

  field :name, type: String
  field :table, type: String
  field :tags, type: Array, default: []
  field :service_name, type: String
  field :deployed, type: Boolean, default: false

  belongs_to :datasource

  validates_presence_of :datasource, :name, :table

  before_save :set_service_name
  before_save :deploy_service


  def check_deployment
    
  end

  private

  def set_service_name
    self.service_name = self.name + "-" + SecureRandom.hex(5)
    self.dcos_name = "/data-microservices/"+self.service_name
  end

  def deploy_service
    file = File.read(Rails.root.to_s + '/app/lib/dcos_services/data_microservice.json')
    file.gsub!("MICROSERVICE_ID_PARAM", self.service_name)
    file.gsub!("DATABASE_URL_PARAM", self.datasource.db_url)
    file.gsub!("TABLE_PARAM", self.table)
    file.gsub!("ELB_PUBLIC_SLAVE_PARAM", "http://m1.dcos/")

    url_file = "/tmp/#{self.service_name}.json"
    out = File.new(url_file, "a+")
    out.puts(file)
    out.close

    self.deployed = DCOS.deploy(url_file)
  end



end
