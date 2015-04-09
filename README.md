# TFG Template

This is a RoR template using The Frontier Group's (TFG) SOE.

## Usage

Clone this repo and run the file `run_me.rb`.

The output of this script should give you the instructions you will need.

## What does the template include out of the box?

- RVM Support via .ruby-gemset and .ruby-version
- PostgreSQL with TFG SOE database.yml. No configuration required.
- Devise implementation using User, includes feature specs for:
  - Resetting password
  - Signing in
  - Signing up
  - Signing out

## TODO

- (Possible) Add in rake task for adding build to CI
- Add generators for CRUD
- Style sign in page
- Make admin pages responsive
- Use dropdown menu for user actions
- Add in mailer defaults for dev (mailcatcher), staging, and production (jazz)
- Custom 404, 500, and maintenance pages
- Custom favicon
- Delete the run_me.rb when app is copied