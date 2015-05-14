#!/usr/bin/ruby

require 'active_support/inflector'
include ActiveSupport::Inflector

def heading(heading)
  puts("#{heading}\n")
end

# app_name can be:
#   * One Two
#   * one-two
#   * one two
#   * one.two
#   * one_two
# These should all come out as: One Two
def normalize_app_name(app_name)
  # . or - or ' ' or _
  regexp = /\.|-|\s|_/
  app_name.titleize.gsub(/\.|-|\s|_/, " ")
end

def replace(path, match, original, with)
  run_command("find #{path} -type f -name '#{match}' -exec sed -i '' s/#{original.chomp}/#{with.chomp}/ {} +")
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

app_name = normalize_app_name(prompt("What is the name of the new app? (EG: App Name)"))
app_name_as_constant = app_name.gsub(" ", "")

target_path = prompt "Where should we install to?", "../"

new_path = File.join(target_path,app_name.parameterize("_"))

heading("Cloning to #{new_path}")
run_command("git clone . #{new_path}")

heading("Changing all instances referencing template name to appropriate casing of #{app_name}")
replace(new_path, "*application.rb", "TfgTemplate", app_name_as_constant)
replace(new_path, "*application.html.haml", "TfgTemplate", app_name_as_constant)
replace(new_path, "*.ruby-gemset", "tfg_template", app_name.parameterize("_"))
replace(new_path, "*database.yml.sample", "tfg-template", app_name.parameterize("-"))
replace(new_path, "*APP_README.md", "TfgTemplate", app_name)

heading("Overwriting existing README.md with template for a Rails app's README")
run_command("cd #{new_path} && mv APP_README.md README.md && cd -")

heading("Comitting changes to your new app at #{new_path}")
run_command("cd #{new_path} && git remote rm origin && git add . && git commit -m '[rails-template] CONFIGURED'")

puts
puts
puts "\e[1;32;40mYour new app is configured at #{new_path}\e[0m"
puts
