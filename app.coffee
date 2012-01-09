crypto = require 'crypto'
express = require 'express'

app = express.createServer()

app.paths =
  public: __dirname + '/public'

# middleware
app.configure ->
  stylus = require 'stylus'

  app.set 'view engine', 'jade'
  app.use stylus.middleware
    src: app.paths.public
    dest: app.paths.public
    compile: (str, path) ->
      stylus(str)
        .set('compress', true)
        .set('filename', path)
        .set('paths', [ __dirname, app.paths.public ])
  app.use express.static(app.paths.public)

# locals
app.locals
  md5: (str) ->
    hash = crypto.createHash 'md5'
    hash.update str
    hash.digest 'hex'

# routes
app.get '/', (req, res) ->
  res.render 'index',
    clients: clients
    projects: projects
    tech: tech
    template: 'index'

app.get '/process', (req, res) ->
  res.render 'process',
    template: 'process'

app.listen process.env.PORT || 8000

# data
projects = [
  name: 'swivel'
  description: '''
    Swivel let people share graphs and numbers on the web. We led the team that
    designed and built Swivel.
    '''
,
  name: 'nko'
  description: '''
    Node Knockout is a 48-hour programming contest that we created. Last year,
    500 people participated and we gave away $40k in prizes.
    '''
,
  name: 'monitaur'
  description: '''
    Built in a weekend with Huned Botee, Monitaur makes it really simple to
    ensure your web servers are running effectively.
    '''
,
  name: 'happytrack'
  description: '''
    An iPhone app we built for a Harvard research project on happiness
    tracking. Featured in the New York Times, NPR, and Science.
    '''
,
  name: 'theglamourist'
  description: '''
    Empowering women through beauty. A great example of our design work.
    '''
,
  name: 'gentrify'
  description: '''
    Built in a weekend with Brent Fitzgerald, Gentriy was a tongue-in-cheek way
    for urbanites to find apartments. Featured in VentureBeat and Laughing
    Squid.
    '''
,
  name: 'lazeroids'
  description: '''
    Another weekend project with Huned Botee. Massively multiplayer online
    asteroids.
    '''
,
  name: 'd2c'
  description: '''
    An iPhone app for attendees of the Data 2.0 Conference, mashing up Google
    Spreadsheets, Factual, Twitter and CrunchBase. Built in our spare time a
    couple weekends before the conference.
    '''
]

clients = [
  name: 'Sequoia Capital'
  url: 'http://www.sequoiacap.com/'
  description: '''
    We've built marketing sites for Sequoia. In addition, we design and
    develop some really cool internal tools for the VC that we can't talk
    about.
    '''
,
  name: 'SpotXchange'
  url: 'http://www.spotxchange.com/publisher_dashboard_video_ad_monetization.html'
  description: '''
    We designed SpotXchange's best-in-class publisher dashboard.
    '''
,
  name: 'Identified'
  url: 'http://www.identified.com/'
  description: '''
    We integrated Identified with Google Contacts, Hotmail, and a dozens of
    other contact services.
    '''
,
  name: 'Minor Ventures'
  url: 'http://minorventures.com/'
  description: '''
    We built Swivel for Minor Ventures, and provided consulting services for
    the site after the company shutdown.
    '''
,
  name: 'Armageddon Energy'
  url: 'http://www.armageddonenergy.com/'
  description: '''
    We built the company's mobile dashboard for tracking solar panel
    effectiveness.
    '''
,
  name: 'Public Library of Science'
  url: 'http://www.plos.org/'
,
  name: 'Mid Ventures'
  url: 'http://midventures.com/'
  description: '''
    We designed and built the mobile app for the Mid Ventures Data 2.0
    Conference.
    '''
]

tech = [
  slug: 'rails'
  name: 'Ruby on Rails'
  url: 'http://rubyonrails.org/'
,
  slug: 'nodejs'
  name: 'node.js'
  url: 'http://nodejs.org/'
,
  slug: 'jquery'
  name: 'jQuery'
  url: 'http://jquery.com/'
,
  slug: 'mongodb'
  name: 'mongoDB'
  url: 'http://www.mongodb.org/'
,
  slug: 'mysql'
  name: 'MySQL'
  url: 'http://www.mysql.com/'
,
  slug: 'ios'
  name: 'iOS'
  url: 'http://www.apple.com/ios/'
,
  slug: 'android'
  name: 'Android'
  url: 'http://www.android.com/'
]
