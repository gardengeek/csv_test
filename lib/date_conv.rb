module DateConv

  def self.convert_keypad(date_str)
    if date_str =~ /^[[:digit:]]{8}$/
      date_str = "#{date_str[4..7]}-#{date_str[0..1]}-#{date_str[2..3]}"
    end
    date_str
  end

  def self.string_to_date(date_str)
    date_str = DateConv::convert_keypad(date_str.to_s)
    
    if date_str.blank? || date_str.nil?
      return_date = nil
    else
      return_date = Date.parse(date_str)
    end
    return_date
  end
end
