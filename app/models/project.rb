class Project
  include Mongoid::Document

  field :name, type: String

  belongs_to :company
  has_many :users
  has_many :dcos_services

end
