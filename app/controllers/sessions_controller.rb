class SessionsController < Clearance::SessionsController
  ssl_required :new, :create
end
