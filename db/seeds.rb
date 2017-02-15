class Seed
  require 'csv'
  attr_reader :sample_user

  def self.start
    seed = Seed.new
    seed.remove_all_existing_data
    seed.create_users
    seed.create_couches
    seed.create_nights
    seed.create_reservations
    seed.display_developer_info
  end

  def remove_all_existing_data
    puts "Clearing out the data currently in your database (Ctrl-C now if that's a bad thing...)"
    sleep(5)
    puts "Too late!"
    Night.destroy_all
    Couch.destroy_all
    Reservation.destroy_all
    User.destroy_all
    puts "Creating fresh, new data"
  end

  def create_users
    number_of_users = 70

    user_bar = ProgressBar.create(title: "Users", total: number_of_users)
    number_of_users.times do
      FactoryGirl.create(:user)
      user_bar.increment
    end

    # generate user for developer log-in
    @sample_user = FactoryGirl.create(:user, email: "user@example.com", phone_number: 111_111_1111)

    user_bar.finish
    puts "#{number_of_users} users created"
  end

  def create_couches
    filename = Rails.root.join("db", "lib", "couch_locations.csv")
    couch_bar = ProgressBar.create(title: "Couches", total: 50)

    CSV.foreach(filename, headers: true) do |row|

      couch_attributes = {
        name: Faker::Ancient.god + " " + Faker::Superhero.suffix + " of " + Faker::HarryPotter.location,
        description: Faker::StarWars.quote,
        street_address: row['street_address'],
        zipcode:  row['zipcode'],
        city: row['city'],
        state: row['state'],
        host: User.all.sample
      }

      Couch.create!(couch_attributes)
      Couch.last.photos.create!(title: "default", image: Rails.root.join("spec/fixtures/test_couch.png").open)

      couch_bar.increment
    end
    sample_user.couches << [FactoryGirl.create(:couch)]
    couch_bar.finish
    puts "#{Couch.count} couches imported"
  end


  def create_nights
    puts "Creating available nights for couches"

    couches = Couch.all
    night_bar = ProgressBar.create(title: "Nights", total: 950)
    couches.each do |couch|
      number_of_contiguous_nights = (2..5).to_a

      number_of_contiguous_nights.sample.times do |i|
        starting_two_weeks_ago = 2.weeks.ago + i.days
        two_weeks_old_night = Night.new(date: starting_two_weeks_ago)
        two_weeks_old_night.save(validate: false)
        two_weeks_old_night.update_attribute(:couch, couch)
        night_bar.increment
      end

      number_of_contiguous_nights.sample.times do |i|
        starting_one_week_ago = 1.weeks.ago + i.days
        one_week_old_night = Night.new(date: starting_one_week_ago)
        one_week_old_night.save(validate: false)
        one_week_old_night.update_attribute(:couch, couch)
        night_bar.increment
      end

      number_of_contiguous_nights.sample.times do |i|
        starting_today = Date.current + i.days
        couch.nights << Night.create(date: starting_today)
        night_bar.increment
      end

      number_of_contiguous_nights.sample.times do |i|
        starting_in_one_week = 1.weeks.from_now + i.days
        couch.nights << Night.create(date: starting_in_one_week)
        night_bar.increment
      end

      number_of_contiguous_nights.sample.times do |i|
        starting_in_two_weeks = 2.weeks.from_now + i.days
        couch.nights << Night.create(date: starting_in_two_weeks)
        night_bar.increment
      end

      couch.save
    end

    night_bar.finish

    nights = Night.count
    puts "#{nights} nights created"
  end

  def create_reservations
    reservation_bar = ProgressBar.create(title: "Reservations", total: 200)
    two_thirds_of_all_users = User.take(User.count * 2/3)
    two_thirds_of_all_users << sample_user

    two_thirds_of_all_users.each do |user|
      number_of_reservations = (2..5).to_a

      number_of_reservations.sample.times do
        reservation = user.reservations.create(status: "confirmed")
        night = Night.unreserved.sample
        night.update_attribute(:reservation, reservation)
        reservation_bar.increment
      end
    end
    reservation_bar.finish

    reservations = Reservation.count
    puts "#{reservations} reservations created"
  end

  def display_developer_info
    puts "\nSample user created"
    puts "\tUser email: '#{@sample_user.email}'"
    puts "\tUser password: 'password'"
    puts "\tUser phone number: '111 111 1111'"
  end

  Seed.start
end
