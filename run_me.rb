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

def prompt(string,default="")
  puts string
  gets.chomp
end

# github_repo = prompt "What is the github repo for the new app?"
# heading("Changing the git origin to #{github_repo}")
# run_command("git remote rm origin")
# run_command("git remote add origin #{github_repo}")

app_name = prompt "What is the name of the new app? (EG: App Name)"
heading("Changing all instances referencing template name to appropriate casing of #{app_name}")
replace("*application.rb", "TfgTemplate", app_name)
replace("*application.html.haml", "TfgTemplate", app_name)
replace("*.ruby-gemset", "tfg_template", app_name.parameterize("_"))
replace("*database.yml", "tfg-template", app_name.parameterize("-"))
replace("*APP_README.md", "TfgTemplate", app_name)

heading("Overwriting existing README.md with template for a Rails app's README")
run_command("mv APP_README.md README.md")
