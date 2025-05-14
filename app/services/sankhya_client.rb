class SankhyaClient
  BASE_URL = "#{ENV.fetch('SANKHYA_BASE_URL')}/mge/service.sbr"

  def initialize(username: ENV.fetch("SANKHYA_USERNAME"), password: ENV.fetch("SANKHYA_PASSWORD"), http: Faraday.new)
    @http = http
    login(username: username, password: password)
  end

  def fetch_partners
    criteria = {
      "expression" => { "$" => "this.CLIENTE = ?" },
      "parameter" => [ { "$" => "S", "type" => "S" } ]
    }
    result = load_records(
      root_entity: "Parceiro",
      criteria: criteria,
      fields: "CODPARC,NOMEPARC,CGC_CPF,DTCAD,DTALTER"
    )
    entities = result.dig("responseBody", "entities", "entity") || []
    SankhyaPartnerMapper.from_sankhya_entities(entities)
  end

  private

  def post_to_sankhya(service_name, body)
    url = "#{BASE_URL}?serviceName=#{service_name}&outputType=json"
    response = @http.post(url) do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["Cookie"] = "JSESSIONID=#{@jsessionid};" if @jsessionid
      req.body = body.to_json
    end
    JSON.parse(response.body)
  end

  def load_records(root_entity:, criteria: nil, fields:, offset_page: 0, include_presentation_fields: "N", try_joined_fields: nil, modified_since: nil, entity_joins: [])
    data_set = {
      "rootEntity" => root_entity,
      "includePresentationFields" => include_presentation_fields,
      "offsetPage" => offset_page.to_s,
      "entity" => [
        {
          "fieldset" => { "list" => fields }
        }
      ]
    }
    data_set["tryJoinedFields"] = try_joined_fields if try_joined_fields
    data_set["modifiedSince"] = modified_since if modified_since
    data_set["criteria"] = criteria if criteria
    data_set["entity"] += entity_joins if entity_joins.any?

    payload = {
      "serviceName" => "CRUDServiceProvider.loadRecords",
      "requestBody" => { "dataSet" => data_set }
    }

    post_to_sankhya("CRUDServiceProvider.loadRecords", payload)
  end

  def login(username:, password:)
    payload = {
      "serviceName" => "MobileLoginSP.login",
      "requestBody" => {
        "NOMUSU" => { "$" => username },
        "INTERNO" => { "$" => password },
        "KEEPCONNECTED" => { "$" => "S" }
      }
    }
    url = "http://teste-sankhya.rhfranquias.com.br:40147/mge/service.sbr?serviceName=MobileLoginSP.login&outputType=json"
    response = @http.post(url) do |req|
      req.headers["Content-Type"] = "application/json"
      req.body = payload.to_json
    end
    data = JSON.parse(response.body)
    jsessionid = data.dig("responseBody", "jsessionid", "$")
    raise "Login inválido" unless jsessionid
    @jsessionid = jsessionid
    jsessionid
  end
end
