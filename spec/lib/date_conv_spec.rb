require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DateConv do

  describe "#convert_keypad" do

    { "" => "",
      "07012008" => "2008-07-01",
      "07/01/2008" => "07/01/2008",
      "11152009" => "2009-11-15",
      "11/23/2009" => "11/23/2009",
      "111209" => "111209",
      '111020101' => '111020101',
      '052004' => '052004'
    }.each do | str_date, result |
      context "with #{str_date} date entered" do

        it "converts string to #{result}" do
          DateConv.convert_keypad(str_date).should == result
        end
      end
    end
  end

  describe "#string_to_date" do

    { "" => nil,
      "07012008" => Date.parse("2008-07-01"),
      "07/01/2008" => Date.parse("07/01/2008"),
      "11152009" => Date.parse("2009-11-15"),
      "11/23/2009" => Date.parse("11/23/2009"),
      "111209" => Date.parse("111209"),
      "04312007" => false  #invalid date
    }.each do | str_date, result |
      context "with #{str_date} date entered" do

        it "converts string to #{result}" do
          DateConv.string_to_date(str_date).should == result
        end
      end
    end
  end
end
