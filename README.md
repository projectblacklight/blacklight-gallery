# Blacklight::Gallery
[![Gem Version](https://badge.fury.io/rb/blacklight-gallery.svg)](http://badge.fury.io/rb/blacklight-gallery) [![CI](https://github.com/projectblacklight/blacklight-gallery/actions/workflows/ruby.yml/badge.svg)](https://github.com/projectblacklight/blacklight-gallery/actions/workflows/ruby.yml)

Image-centric "Gallery" views for Blacklight search results.

## Installation

Add this line to your Blacklight application's Gemfile:

    gem 'blacklight-gallery'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blacklight-gallery

## Usage

### With Sprockets

If your asset pipeline uses Sprockets, simply run the gallery generator:

```sh
$ rails g blacklight_gallery:install
```

### With Importmaps

New installations of Blacklight will probably use [Importmaps](https://github.com/rails/importmap-rails) to manage javascript assets. In order to support the masonry and slideshow views, jQuery needs to be added to your application Importmaps configuration.

In addition to running the `blacklight_gallery:install` generator, add this line to `/config/importmap.rb`:

```ruby
pin "jquery", to: "https://code.jquery.com/jquery-3.7.1.min.js"
```

Then append import declarations in your `app/assets/javascript/application.js`:

```js
import 'jquery'
import 'blacklight-gallery'
```

### With Node-based JS bundlers

For node-based bundlers add `blacklight-gallery masonry-layout@v4` as a dependency and add this to your entrypoint:
```js
import 'blacklight-gallery/vendor/assets/javascripts/imagesloaded.pkgd.js'
import 'blacklight-gallery/app/javascript/blacklight-gallery/slideshow'
import 'blacklight-gallery/app/javascript/blacklight-gallery/masonry'
```

### With Propshaft

Propshaft will process and include any CSS files in your `app/assets/stylesheets` directory. The `blacklight_gallery:install` generator adds [a file](https://github.com/projectblacklight/blacklight-gallery/blob/v4.8.4/lib/generators/blacklight_gallery/templates/blacklight_gallery.css.scss) to `app/assets/stylesheets` that loads the included styles for all views.
The styles require compilation from SASS to CSS, which will require usage of a compiler like [`dartsass-rails`](https://github.com/rails/dartsass-rails).

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

### Building Internal Test App

Within the blacklight-gallery root directory
- Install gems
```
bundle install
```
- Run the rake task that builds internal test app and runs the test suite.  
```
bundle exec rake
```

- By default, the rake task runs with the current rails and blacklight versions defined in the gemspec file, you can modify the rake task with the following environment variables:
  - Pass custom options to the rails engine cart using the `ENGINE_CART_OPTIONS` environment variable. 
  - Set a specific rails version with `export RAILS_VERSION=some_version_#`.
  - Set a specific blacklight version with `export BLACKLIGHT_VERSION=some_version_#`.


### Stylesheets

- When using the modern rails asset pipeline (`importmap` + `propshaft`) to build the internal test app, we need to manually include the `.scss` stylesheets in the host application's stylesheet entrypoint
- Copy the gem's `.scss` stylesheets in `/app/assets/stylesheets` to `/.internal_test_app/assets/stylesheets`
- Import stylesheets in internal test app stylesheet entrypoint.
```
# internal_test_app stylesheet entrypoint 

@import 'gallery';
@import 'slideshow';
@import 'masonry';
@import 'osd_viewer';
  ```
- Compile scss from within `/.internal_test_app` with the following `yarn` command

```
yarn build:css
```

### Jquery
- The masonry and slideshow views require jquery. There are multiple ways to do this, and we document the
- When running the generator with the current gemspec, and the modern rails asset pipeline (`importmap`, `propshaft`, and/or `node` based bundlers), 
we have to import jquery manually in the internal test app. You can do this with importmaps with the following additions to your `/.internal_test_app/config/importmap.rb` file:

```
# /.internal_test_app/config/importmap.rb

pin "jquery", to: "https://code.jquery.com/jquery-3.7.1.min.js"
```
- Once jquery is added to the internal test app, import the following to the internal test app `application.js` entrypoint
```
# /.internal_test_app/javascrpt/application.js

# import jquery and 'blacklight-gallery'

import 'jquery'
import 'blacklight-gallery'
```

### Start Rails Server
- Run the rake task to start the rails server for the internal test app from the blacklight gallery root directory
```
bundle exec rake server
```

### Specs

- Run specs with current internal test app configuration
  `bundle exec rake`

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
