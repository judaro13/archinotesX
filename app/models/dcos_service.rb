class DcosService
  include Mongoid::Document

  field :dcos_id, type: String
  field :dcos_name, type: String
  field :end_points, type: Array, default: []
  field :status, type: String

end
