# README

This is the highest form of programmable flattery. A cloning exercise that doesn't involve sheep, but does mimic the functionality of services such as Airbnb.

## With PadCrash you can, 
  * Create a user account
  * Search and reserve available pads
  * Chat with host about each reservation
  * Upload your own pad to rent out for travelers

# [Check It Out](https://padcrash.herokuapp.com)

### Pad availability extends between February - March 2017.
### To check out these features for yourself login with:
  * email:    user@example.com
  * password: password

### Features we're proud of 
  * Used Travis CI for continuous integration
  * 2-factor authentication via Twilio
  * Geocoder used to integrate couch locations for display on Google Maps (COMING SOON!)
  * Upload photos of your pad with Carrierwave
  * Use of AJAX to update available pad Search
  * CSS: flexboxes on flexboxes

We believe in starting off on the right [♫](https://gist.github.com/tmikeschu/4ccb96fbca3734d07a4e4a5e1c5e2ae5).

[![Code Climate](https://codeclimate.com/github/tmikeschu/air_bnb_clone/badges/gpa.svg)](https://codeclimate.com/github/tmikeschu/air_bnb_clone)
[![Test Coverage](https://codeclimate.com/github/tmikeschu/air_bnb_clone/badges/coverage.svg)](https://codeclimate.com/github/tmikeschu/air_bnb_clone/coverage)

### To clone down our project and run locally
```
git clone https://github.com/tmikeschu/air_bnb_clone.git
cd air_bnb_clone
bundle install
rake db:{create,setup}
clear & rspec
rails server
```
