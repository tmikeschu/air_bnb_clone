require 'csv'

puts "Clearing out the data currently in your database (Ctrl-C now if that's a bad thing...)"
sleep(5)
puts "Too late!"
Night.destroy_all
Couch.destroy_all
Reservation.destroy_all
User.destroy_all

# use progressbars and notes to let the user know what is going on
# get rid of the CouchesImporter class and just do it as a script
#

puts "Creating fresh, new data"

number_of_users = 70
user_bar = ProgressBar.create(title: "Users", total: number_of_users)

number_of_users.times do
  FactoryGirl.create(:user)
  user_bar.increment
end

# generate user for developer log-in
sample_user = FactoryGirl.create(:user, email: "user@example.com", phone_number: 111_111_1111)

user_bar.finish

class CouchesImporter

  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    couch_bar = ProgressBar.create(title: "Couches", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|

      couch_attributes = {
        name: Faker::Ancient.god + " " + Faker::Superhero.suffix + " of " + Faker::HarryPotter.location,
        description: 5.times { Faker::StarWars.quote },
        street_address: row['street_address'],
        zipcode:  row['zipcode'],
        city: row['city'],
        state: row['state'],
        host: User.all.sample
      }

      Couch.create!(couch_attributes)

      couch_bar.increment
    end
    couch_bar.finish
    puts "#{number_of_lines - 1} couches imported"
  end
end

CouchesImporter.new(Rails.root.join("db", "lib", "couch_locations.csv")).import

couches = Couch.all

puts "Creating available nights for couches"

night_bar = ProgressBar.create(title: "Nights", total: 160)
couches.each do |couch|
  number_of_contiguous_nights = (1..5).to_a

  number_of_contiguous_nights.sample.times do |i|
    starting_two_weeks_ago = 2.weeks.ago + i.days
    couch.nights << Night.create(date: starting_two_weeks_ago)
  end

  number_of_contiguous_nights.sample.times do |i|
    starting_one_week_ago = 1.weeks.ago + i.days
    couch.nights << Night.create(date: starting_one_week_ago)
  end

  number_of_contiguous_nights.sample.times do |i|
    starting_today = Date.current + i.days
    couch.nights << Night.create(date: starting_today)
  end

  number_of_contiguous_nights.sample.times do |i|
    starting_in_one_week = 1.weeks.from_now + i.days
    couch.nights << Night.create(date: starting_in_one_week)
  end

  number_of_contiguous_nights.sample.times do |i|
    starting_in_two_weeks = 2.weeks.from_now + i.days
    couch.nights << Night.create(date: starting_in_two_weeks)
  end

  night_bar.increment
  couch.save
end

night_bar.finish

nights = Night.count
puts "#{nights} total nights created"

puts "\nSample user created!"
puts "\tUser email: '#{sample_user.email}'"
puts "\tUser password: 'password'"
puts "\tUser phone number: '111 111 1111'"
