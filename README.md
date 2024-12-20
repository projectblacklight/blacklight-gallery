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
