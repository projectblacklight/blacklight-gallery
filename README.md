# Blacklight::Gallery
[![Gem Version](https://badge.fury.io/rb/blacklight-gallery.svg)](http://badge.fury.io/rb/blacklight-gallery) [![CI](https://github.com/projectblacklight/blacklight-gallery/actions/workflows/ruby.yml/badge.svg)](https://github.com/projectblacklight/blacklight-gallery/actions/workflows/ruby.yml)

Image-centric "Gallery" views for Blacklight search results.

## Installation

Add this line to your Blacklight application's Gemfile:

    gem 'blacklight-gallery'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install blacklight-gallery

## Usage

### Installation with Sprockets/Propshaft and Importmaps

If your asset pipeline uses Sprockets/Propshaft with Importmaps, run the gallery generator:

```sh
$ rails g blacklight_gallery:install
```

### Installation for Node-based JS bundlers

For node-based bundlers add `blacklight-gallery masonry-layout@v4` as a dependency and add this to your entrypoint:
```js
import 'blacklight-gallery/vendor/assets/javascripts/imagesloaded.pkgd.js'
import 'blacklight-gallery/app/javascript/blacklight-gallery/slideshow'
import 'blacklight-gallery/app/javascript/blacklight-gallery/masonry'
```

## Manual Installation

See the wiki page on [manual installation](https://github.com/projectblacklight/blacklight-gallery/wiki/Manual-Installation) to customize which views and related assets to install into your application.

## Screenshot

![Screenshot](docs/screen_shot.png)

##  Local Development Environment

### Requirements 

- Ruby >= 3.2
- Node >= 16.13.0 (LTS)
- Yarn >= 1.22.22
- Java >= openjdk-21
  - Building the internal test app will install Solr 9.6.1 locally via [`solr_wrapper`](https://github.com/cbeer/solr_wrapper)

### Building and testing test application
By default, the rake tasks below run with the current Rails and Blacklight versions defined in the gemspec file. You can modify the rake task with the following environment variables:
- Pass custom options to the rails engine cart using the `ENGINE_CART_RAILS_OPTIONS` environment variable.
- Set a specific Rails version with `export RAILS_VERSION=some_version_#`.
- Set a specific Blacklight version with `export BLACKLIGHT_VERSION=some_version_#`.
- Use Blacklight on the latest commit from the repository with `export BLACKLIGHT_VERSION=github`

#### Building Internal Test App
Within the blacklight-gallery root directory:
- Install gems
  ```
  bundle install
  ```

- Run the rake task that builds internal test app  
  ```
  bundle exec rake engine_cart:generate
  ```

- A test Rails application is built in the `.internal_test_app` directory with Blacklight and Blacklight-Gallery 

#### Start Rails Server
Within the blacklight-gallery root directory:
- Run the rake task to start the rails server and Solr for the internal test app
  ```
  bundle exec rake server
  ```

#### Run Specs in test application
- Run specs with current internal test app configuration. Generates internal test app, if not already present.
  ```
  bundle exec rake
  ```

### Solr
- The default solr port is at 8983

## Contributing

1. Fork it ( http://github.com/<my-github-username>/blacklight-gallery/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Releasing

1. Edit `lib/version.rb` and `package.json` to set the new version
2. Commit the changes e.g. `git commit -am "Bump version to X.X.X"`
3. Push release to rubygems `bundle exec rake release`
4. Push release to NPM `npm publish`
5. Create a release on github with the tag that was just created: https://github.com/projectblacklight/blacklight-gallery/releases/new
