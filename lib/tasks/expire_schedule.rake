namespace :feedback do
  desc "expire schedule feedback notification"
  task expire_schedule: :environment do
    Schedule.after_days(6).delete_all
  end
end