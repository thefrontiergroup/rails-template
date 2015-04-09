if Rails.application.config.should_seed_application_data

  Dir.open("lib/tasks/seeds").each do |filename|
    next if [".", ".."].include?(filename)
    Rake::Task["db:seed:#{File.basename(filename, '.rake')}"].invoke
  end

end