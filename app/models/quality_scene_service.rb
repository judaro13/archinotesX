class QualitySceneService
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :table, type: String
  field :attributes, type: Array, default: []
  field :display_type, type: String

  belongs_to :scene
  belongs_to :dcos_service
  has_one :data_icroservice

end
