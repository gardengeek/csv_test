require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Person do

  describe '#age' do
    person = Person.new
    { Date.today - 1.year => 1,
      Date.today - 1.year - 1.day => 1,
      Date.today - 1.year + 1.day => 0,
      Date.today - 3.year => 3,
      Date.today - 3.year - 1.day => 3,
      Date.today - 3.year + 1.day => 2,
      '' => ''
    }.each do |birth_date, age|
      context "with birth date of #{birth_date}" do
        it "calculates the age of #{age}" do
          person.birth_date = birth_date
          person.age.should == age
        end
      end
    end
  end

  describe '#age_at_created' do
    person = Person.new
    { [Date.parse('1970-02-23'), Date.parse('2001-02-23 12:00:00')] => 31,
      [Date.parse('1970-02-23'), Date.parse('2001-02-22 12:00:00')] => 30,
      [Date.parse('1970-02-23'), Date.parse('2001-02-24 12:00:00')] => 31,
      [Date.parse('1972-02-29'), Date.parse('2001-02-28 12:00:00')] => 29,
      [Date.parse('1972-02-29'), Date.parse('2001-03-01 12:00:00')] => 29,
      [Date.parse('1972-02-29'), Date.parse('2001-02-27 12:00:00')] => 28,
      '' => ''
    }.each do |(birth_date, created_at), age|
      context "with birth date of #{birth_date}" do
        it "calculates the age of #{age}" do
          person.birth_date = birth_date
          person.created_at = created_at
          person.age_at_create.should == age
        end
      end
    end
  end
end
