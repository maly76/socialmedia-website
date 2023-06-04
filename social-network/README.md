

installed / binded:
    gem "clearance"
    gem 'bootstrap', '~> 5.1.3'
    gem 'image_processing'
    gem "bootstrap_form", "~> 5.0"

    bundle install
    rails generate clearance:install
    bin/rails action_text:install

DB:
    bin/rails generate scaffold Post user:belongs_to body:text onlyForFriends:boolean
    bin/rails generate scaffold Comment user:belongs_to body:text post:belongs_to
    bin/rails generate scaffold Profile user:belongs_to username:text onlyForFriends:boolean imageurl:string

    bin/rails generate migration add_title_to_posts title:string

    bin/rails generate migration add_birthday_to_profiles birthday:date
    bin/rails generate migration add_fullname_to_profiles fullname:string
    bin/rails generate migration add_phone_number_to_profiles phone_number:string

    bin/rails generate migration add_country_to_profiles country:string
    bin/rails generate migration add_city_to_profiles city:string
    bin/rails generate migration add_street_to_profiles street:string

    bin/rails generate scaffold Friendship_Request from_user:belongs_to to_user:belongs_to
    bin/rails generate scaffold Friendship user:belongs_to friend:belongs_to
