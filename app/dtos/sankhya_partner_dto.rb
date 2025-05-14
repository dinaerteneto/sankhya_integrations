class SankhyaPartnerDto < BaseDto
  attribute :external_id, :integer
  attribute :name, :string
  attribute :document, :string
  attribute :created_at, :date
  attribute :updated_at, :date

  # validações opcionais
  validates :external_id, :name, :document, presence: true
end
