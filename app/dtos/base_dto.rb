class BaseDto
  include ActiveModel::Model
  include ActiveModel::Attributes
  include ActiveModel::Serializers::JSON

  # Permite .to_json e .serializable_hash
  def attributes
    @attributes ||= {}
  end
end 