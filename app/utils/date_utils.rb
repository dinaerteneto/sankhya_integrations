require "date"

module DateUtils
  def self.to_iso_date(date_str)
    return nil if date_str.nil? || date_str.strip.empty?
    date_str = date_str.strip[0, 10] # pega só os 10 primeiros caracteres
    begin
      Date.strptime(date_str, "%d/%m/%Y").strftime("%Y-%m-%d")
    rescue ArgumentError
      date_str
    end
  end
end
