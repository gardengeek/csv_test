module Format

  def self.left_fixed(data, fixed_length, filler = ' ')
    data.to_s.ljust(fixed_length, filler)[0..(fixed_length - 1)]
  end

  def self.number_right_fixed(number, fixed_length, filler = ' ')
    number.to_s.gsub(/[^0-9]/,'')[0..(fixed_length - 1)].rjust(fixed_length, filler)
  end

  def self.date_yyyymmdd(date)
    return(left_fixed(nil, 8)) if date.nil?
    "#{date.year}#{date.month.to_s.rjust(2,'0')}#{date.day.to_s.rjust(2,'0')}"
  end
end
