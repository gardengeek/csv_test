Factory.define :person do |p|
  p.first_name "Alice"
  p.last_name "Tester"
  p.state {State.find_by_code('IN')}
end
