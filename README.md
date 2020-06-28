# [jekyll-uglify](https://rubygems.org/gems/jekyll-uglify)
[![Gem Version](https://badge.fury.io/rb/jekyll-uglify.svg)](https://badge.fury.io/rb/jekyll-uglify)

A Jekyll command plugin for uglifying given JS files or directories using [Uglifier](https://github.com/lautis/uglifier), a Ruby wrapper for UglifyJS by [lautis](https://github.com/lautis).

## Installation
``` 
gem install jekyll-uglify
```

## Set Up
In `Gemfile`
``` ruby
...
group :jekyll_plugins do
  ...
  gem 'jekyll-uglify'
end
```

To enable options in `_config.yml`
``` yaml
jekyll-uglify:
  harmony: true # Enable experimental ES6 conversion
```
You can find all available options and default values [here](https://github.com/lautis/uglifier#usage).

## Usage
```
bundle exec jekyll uglify FILEPATH [ADDITIONAL_FILEPATHS]
```
You can list any number of files or directories to be uglified. Include this command in your build process to uglify JS at build time.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the jekyll-uglify project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hofers/jekyll-uglify/blob/master/CODE_OF_CONDUCT.md).
