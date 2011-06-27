class PasswordsController < Clearance::PasswordsController
  ssl_required :edit, :update
end
