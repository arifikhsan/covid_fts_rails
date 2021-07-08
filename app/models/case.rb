class Case
  include Mongoid::Document
  include Mongoid::Timestamps
  field :key, type: Integer
  field :active_cumulative, type: Integer
  # field :active, type: Integer
  # field :positive, type: Integer
  # field :recover, type: Integer
  # field :death, type: Integer
  # field :positive_cumulative, type: Integer
  # field :recover_cumulative, type: Integer
  # field :death_cumulative, type: Integer
  # field :last_update, type: Integer
  field :date_time, type: String
end
