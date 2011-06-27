namespace :db do
  namespace :fixtures do
    
    desc 'Set FIXTURES_PATH environment variable'
    task :set_fixtures_path => :environment do
      ENV['FIXTURES_PATH'] ||= File.join('spec', 'fixtures')
    end

    task :load => :set_fixtures_path
 
    desc 'Create YAML test fixtures from data in an existing database.  
    Defaults to development database.  Set RAILS_ENV to override.'
    task :dump => :set_fixtures_path do
      sql  = "SELECT * FROM %s"
      skip_tables = ["schema_migrations"]
      ActiveRecord::Base.establish_connection(Rails.env)
      tables = ENV['TABLES'] && ENV['TABLES'].split(',')
      tables ||= (ActiveRecord::Base.connection.tables - skip_tables)
 
      tables.each do |table_name|
        i = "000"
        File.open("#{RAILS_ROOT}/spec/fixtures/#{table_name}.yml", 'w') do |file|
          data = ActiveRecord::Base.connection.select_all(sql % table_name)
          file.write data.inject({}) { |hash, record|
            hash["#{table_name}_#{record.has_key?("id") ? record["id"] : i.succ!}"] = record
            hash
          }.to_yaml
        end
      end
    end
  end
end
