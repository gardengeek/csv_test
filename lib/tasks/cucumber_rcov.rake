unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks

  vendored_cucumber_bin = Dir["#{Rails.root.to_s}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first
  $LOAD_PATH.unshift(File.dirname(vendored_cucumber_bin) + '/../lib') unless vendored_cucumber_bin.nil?

  begin
    require 'cucumber/rake/task'

    namespace :cucumber do
      namespace :rcov do
        desc "Delete aggregate coverage data."
        task(:clean) do
          rm_f "coverage.data"
        end

        Cucumber::Rake::Task.new({:aggregate => 'db:test:prepare'}, '') do |t|
          t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
          t.rcov = true
          t.rcov_opts << "--aggregate coverage.data --exclude features\/,spec\/"
          t.profile = 'default'
        end
      end

      desc "Run features that should pass with RCov"
      task :rcov => ['cucumber:rcov:clean','cucumber:rcov:aggregate']
    end
  rescue LoadError
    # Do nothing. Let the standard rake file create the task
  end
end
