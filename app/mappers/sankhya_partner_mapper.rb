require_relative "../utils/date_utils"

class SankhyaPartnerMapper
  def self.from_sankhya_entity(entity)
    SankhyaPartnerDto.new(
      external_id: entity.dig("f0", "$").strip,
      name:        entity.dig("f1", "$").strip,
      document:    entity.dig("f2", "$").strip,
      created_at:  DateUtils.to_iso_date(entity.dig("f3", "$")&.strip),
      updated_at:  DateUtils.to_iso_date(entity.dig("f4", "$")&.strip)
    )
  end

  def self.from_sankhya_entities(entities)
    entities.map { |entity| from_sankhya_entity(entity) }
  end
end
