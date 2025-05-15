# Blacklight::Gallery
[![Gem Version](https://badge.fury.io/rb/blacklight-gallery.svg)](http://badge.fury.io/rb/blacklight-gallery) [![CI](https://github.com/projectblacklight/blacklight-gallery/actions/workflows/ruby.yml/badge.svg)](https://github.com/projectblacklight/blacklight-gallery/actions/workflows/ruby.yml)

Gallery views for Blacklight search results

## Installation

Add this line to your Blacklight application's Gemfile:

    gem 'blacklight-gallery'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blacklight-gallery

## Usage

Run the gallery generator for Sprockets:

    $ rails g blacklight_gallery:install

Or for node based bundlers add `blacklight-gallery masonry-layout@v4` as a dependencies and add this to your entrypoint:
```js
import 'blacklight-gallery/vendor/assets/javascripts/imagesloaded.pkgd.js'
import 'blacklight-gallery/app/javascript/blacklight-gallery/slideshow'
import 'blacklight-gallery/app/javascript/blacklight-gallery/masonry'
```

## Available Views
If you would like to add or remove any particular view either add or remove the following configurations from your Blacklight controller.

### Gallery

    config.view.gallery.partials = [:index_header, :index]

### Masonry

    config.view.masonry.partials = [:index]

### Slideshow

    config.view.slideshow.partials = [:index]

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
- Run the rake task that builds internal test app with the current rails and blacklight versions defined in the gemspec file. 
This will also run the specs. You can pass custom options to the rails engine cart using the `ENGINE_CART_OPTIONS` environment variable

```
bundle exec rake
```
With rails engine cart options:
```
bundle exec rake ENGINE_CART_OPTIONS="--js=esbuild"
```

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

- masonry and slideshow views have a jquery dependency
- when running the generator with the current gemspec, and the modern rails asset pipeline (`importmap`, `propshaft`, and/or `node` based bundlers),
we have to import jquery manually in the internal test app
- once the jquery is added to the internal test app, import the following to the internal test app `application.js` entrypoint 

```
# ./.internal_test_app/javascrpt/application.js

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
1. Commit the changes e.g. `git commit -am "Bump version to X.X.X"`
1. Push release to rubygems `bundle exec rake release`
1. Push release to NPM `npm publish`
1. Create a release on github with the tag that was just created: https://github.com/projectblacklight/blacklight-gallery/releases/new
