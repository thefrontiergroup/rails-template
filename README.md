# TFG Template

This is a RoR template using The Frontier Group's (TFG) SOE.

## Usage

```
git clone https://github.com/thefrontiergroup/rails-template
cd rails-template
gem install bundler
bundle
bin/setup
# Run this to create a new Rails application from the template
bin/copy_template
```

The output of this script should give you the instructions you will need.

## What does the template include out of the box?

### Configuration

- Add in mailer defaults for staging, and production (jazz)
- Mailer configuration for development environment
- PostgreSQL with TFG SOE database.yml. No configuration required.
- RVM Support via .ruby-gemset and .ruby-version
- Seeds configuration via SeedHelper, including seeding some initial Users

### Functionality

- Script to spin up app (`bin/setup`)
- Admin and Member Users with CRUD for both
- Authorization with Pundit with full unit tests
- Custom 404, 500, and maintenance pages
- Custom favicon
- Dashboard for admins and members
- Devise implementation using User, includes feature specs for:
  - Resetting password
  - Signing in
  - Signing up
  - Signing out
- Easy sign in functionality to speed up development
- Responsive and Desktop styles

## TODO

- (Possible) Add in rake task for adding build to CI
- Use dropdown menu for user actions
