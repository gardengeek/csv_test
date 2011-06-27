unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks

  begin
    require 'rspec/core'
    require 'rspec/core/rake_task'

    namespace :spec do
      namespace :rcov do
        desc "Run all specs with rcov --aggregate"
        RSpec::Core::RakeTask.new(:aggregate => ['baseline:rcov:clean', 'db:test:prepare']) do |t|
          t.rcov = true
          t.pattern = "./spec/**/*_spec.rb"
          t.rcov_opts = '--aggregate coverage.data --exclude /gems/,/Library/,/usr/,lib/tasks,.bundle,config,/lib/rspec/,/lib/rspec-'
        end
      end
    end
  rescue LoadError
  end
end
