# Applitrack Ruby Gem
This gem is for using Frontline Education's Applicant Tracking (formerly Applitrack) API through an API Partner account.

## Installation
    gem install applitrack

## Usage

### Setup
Setup an API Partner account through the Applitrack dashboard. During setup you will have to provide a username & password  for that account. If you don't have administrator access to Applitrack your partner organization will have to provide those crednetials for you.

Get the CLIENT CODE of the organization whose data you will be using through the API. You can ask Applitrack support for this information or if you have access to the Applitrack dashboard you can simply look at the URL ('https://applitrack.com/CLIENTCODE/onlineapp/...')

    require 'applitrack'

    # set username, password, client_code separately
    Applitrack.username = 'username'
    Applitrack.password = 'password'
    Applitrack.client_code = 'clientcode'

    # or do it all at once
    Applitrack.config = {
        username: 'username',
        password: 'password',
        client_code: 'clientcode
    }

### Accessing APIs
Currently this gem supports basic API calls to Applications, Positions, and JobPostings.
For example:


    # load list of Positions
    Applitrack::Position.list

    # load single Position
    Applitrack::Position.retrieve(POSITION_ID)

You can pass a hash of options into .list to attach filters to an API call.
For example:

    # load JobPostings where title == 'Cool Job'
    Applitrack::JobPosting.list(title: 'Cool Job')

    # load Position where position code == 3
    Applitrack::Position.list(position_code: 3)

    # load Application where name == 'Tony Manero'
    Applitrack::Application.list(first_name: 'Tony', last_name: 'Manero')

The accepted options and what they translate into for the Applitrack API are found within .list_filters within each resource's class. Passing multiple options into .list only ANDs the conditions.
