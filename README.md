# TFG Template

This is a RoR template using The Frontier Group's (TFG) SOE.

## Usage

Clone this repo and run the file `run_me.rb`.

The output of this script should give you the instructions you will need.

## What does the template include out of the box?

- RVM Support via .ruby-gemset and .ruby-version
- PostgreSQL with TFG SOE database.yml. No configuration required.
- Rake task to spin up app (`rake spin_up`)
- Devise implementation using User, includes feature specs for:
  - Resetting password
  - Signing in
  - Signing up
  - Signing out
- Authorization with Pundit with full unit tests
- Admin and Member Users
- Dashboard and CRUD (including soft delete via the paranoia gem) for Users for Admins with full unit and feature tests
- Dashboard with update profile link for Members with full unit and feature tests
- Seeds configuration via SeedHelper, including seeding some initial Users
- Easy sign in functionality to speed up development
- Basic set of styles for all pages above

## TODO

- (Possible) Add in rake task for adding build to CI
- Add generators for CRUD
- Make admin pages responsive
- Use dropdown menu for user actions
- Add in mailer defaults for dev (mailcatcher), staging, and production (jazz)
- Custom 404, 500, and maintenance pages
- Custom favicon
- Delete the run_me.rb when app is copied
- Validate format of email address