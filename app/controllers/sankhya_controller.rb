class SankhyaController < ApplicationController
  def index
    client = SankhyaClient.new()
    partners = client.fetch_partners
    render json: partners.map { |p|
      {
        external_id: p.external_id,
        name: p.name,
        document: p.document,
        created_at: p.created_at,
        updated_at: p.updated_at
      }
    }
  end
end
