require 'active_support/inflector'
include ActiveSupport::Inflector

def heading(heading)
  puts("#{heading}\n")
end

def replace(path, original, with)
  run_command("find . -type f -name '#{path}' -exec sed -i '' s/#{original.chomp}/#{with.chomp}/ {} +")
end

def run_command(command)
  puts "About to run: #{command}"
  `#{command}`
end

def prompt(string,default=nil)
  string = "#{string} (#{default})" unless default.nil?
  print "#{string}: "
  result = gets.chomp
  result.empty? ? default : result
end

# github_repo = prompt "What is the github repo for the new app?"
# heading("Changing the git origin to #{github_repo}")
# run_command("git remote rm origin")
# run_command("git remote add origin #{github_repo}")

app_name = prompt "What is the name of the new app? (EG: App Name)"

target_path = prompt "Where should we install too?", "../"

new_path = File.join(target_path,app_name.parameterize("_"))

heading("Cloning to #{new_path}")
run_command("git clone . #{new_path}")

heading("Changing all instances referencing template name to appropriate casing of #{app_name}")
replace(File.join(new_path,"*application.rb"), "TfgTemplate", app_name)
replace(File.join(new_path,"*application.html.haml"), "TfgTemplate", app_name)
replace(File.join(new_path,"*.ruby-gemset"), "tfg_template", app_name.parameterize("_"))
replace(File.join(new_path,"*database.yml"), "tfg-template", app_name.parameterize("-"))
replace(File.join(new_path,"*APP_README.md"), "TfgTemplate", app_name)

heading("Overwriting existing README.md with template for a Rails app's README")
run_command("cd #{new_path} && mv APP_README.md README.md && cd -")
