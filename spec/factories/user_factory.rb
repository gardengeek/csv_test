Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |u|
  u.email                 { Factory.next :email }
  u.first_name {|user| user.email.match(/(.*)@/)[1].titleize }
  u.last_name "Jones"
  u.password "testing"
  u.time_zone "Eastern Time (US & Canada)"
  u.confirmed_at 3.days.ago
  u.country_code "US"
  u.company_name "Princeton‑Plainsboro Teaching Hospital (PPTH)"
  u.address_line_1 { "#{rand(900) + 100} #{%w(Maple Oak Hickory Apple Ash Beech Cedar Cypress).sort_by{ rand - 0.5 }.first} #{%w(St Ave Rd Dr).sort_by{ rand - 0.5 }.first}" }
  u.city { %w(Goshen Auburn Bluffton Butler Clinton Columbus Decatur Elkhart Gary Indianapolis Greensburg).sort_by{ rand - 0.5 }.first }
  u.postal_code { "#{rand(89999) + 10000}" }
  u.state_code {|i| i.country.state_codes.sort_by{ rand - 0.5 }.first }
  u.phone_number {'123-456-7890'}
end

Factory.define :admin_user, :parent => :user do |a|
  a.roles { |user|
    [
      Role.find_by_title('admin') || Factory(:role, :title => 'admin')
    ]
  }
end
