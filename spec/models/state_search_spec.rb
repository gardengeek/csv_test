require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe StateSearch do
  describe '#format_date_yyyymmdd' do
    { Date.parse('2009-01-05') => '20090105',
      Date.parse('2011-12-15') => '20111215',
      nil => '        '
    }.each do |date, str|
      context "with a date of #{date}" do
        it "should return #{str}" do
         StateSearch.format_date_yyyymmdd(date).should == str
        end
      end
    end
  end

  describe '#format_left_fixed' do
    { ['Sam', 10, nil] => 'Sam       ',
      ['Sam', 9, '0'] => 'Sam000000',
      ['', 10, nil] => '          ',
      ['', 9, '0'] => '000000000',
      [9, 5, nil] => '9    ',
      [7, 5, '0'] => '70000'
    }.each do |(data, fixed_length, filler), returned_value|
      context "with a value of #{data}" do
        it "should return #{returned_value}" do
          if filler.nil?
            result = StateSearch.format_left_fixed(data, fixed_length)
            result.should == returned_value
          else
            result = StateSearch.format_left_fixed(data, fixed_length, filler)
            result.should == returned_value
          end

        end
      end
    end
  end

  describe '#number_right_fixed' do
    { [7, 10, nil] => '         7',
      [78, 9, '0'] => '000000078',
      ['', 10, nil] => '          ',
      ['', 9, '0'] => '000000000',
      ['9', 5, nil] => '    9',
      ['7', 5, '0'] => '00007'
    }.each do |(data, fixed_length, filler), returned_value|
      context "with a value of #{data}" do
        it "should return #{returned_value}" do
          if filler.nil?
            result = StateSearch.number_right_fixed(data, fixed_length)
            result.should == returned_value
          else
            result = StateSearch.number_right_fixed(data, fixed_length, filler)
            result.should == returned_value
          end
        end
      end
    end
  end
end

