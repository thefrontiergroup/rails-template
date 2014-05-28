def replace(path, original, with)
  run_command("find . -type f -name '#{path}' -exec sed -i '' s/#{original.chomp}/#{with.chomp}/ {} +")
end

def run_command(command)
  puts "About to run: #{command}"
  `#{command}`
end

def prompt(string)
  puts string
  gets
end

# github_repo = prompt "What is the github repo for the new app?"
# run_command("git remote rm origin")
# run_command("git remote add origin #{github_repo}")

app_name = prompt "What is the name of the new app? (EG: App Name)"
replace("*application.rb", "TfgTemplate", app_name)
replace("*application.html.haml", "TfgTemplate", app_name)
