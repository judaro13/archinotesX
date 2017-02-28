class Scene
  include Mongoid::Document

  field :name, type: String
  field :description, type: String

  has_many :quatlity_scenes

end
