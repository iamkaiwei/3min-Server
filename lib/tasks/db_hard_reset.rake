namespace :db do
	desc "Reset everything in the database"
	task :hard_reset => :environment do
		begin
			ActiveRecord::Base.connection_pool.disconnect!

			ActiveRecord::Base.connection.tables.each do |table_name|
				ActiveRecord::Base.connection.execute("DROP TABLE IF EXISTS #{table_name}")
			end

			ActiveRecord::Base.connection.execute("DROP EXTENSION IF EXISTS hstore")
		rescue
			Rake::Task["db:create"].invoke
		end

		Rake::Task["db:schema:dump"].invoke
		Rake::Task["db:migrate"].invoke
		Rake::Task["db:seed"].invoke
	end
end
