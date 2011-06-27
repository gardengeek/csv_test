Factory.define :role do |f|
  f.sequence(:title) {|n| "role #{n}"}
end
