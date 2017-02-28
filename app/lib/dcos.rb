class DCOS

  def self.deploy(file)
    response = `dcos marathon app add #{file}`
    response.nil?
  end

  def self.get_endpoints(dcos_id)
    response = `dcos marathon app show #{dcos_id}`
    if response
      json_resonse = JSON.parse( response )
      endpoints = []
      url = json_resonse["tasks"].first["host"]
      json_resonse["tasks"].first["ports"].each do |port|
        endpoints << url+":#{port}"
      end
      return endpoints
    end
    false
  rescue
    false
  end

end
