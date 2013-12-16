A generator for setting up a Rails app for Ember. Installs `ember-rails`, `guard`, `teaspoon`, `guard-teaspoon`. Sets up guard files and runs other generators to set up ember structure.

Add `glm_ember` to your Gemfile

```
gem 'glm_ember', git: "https://github.com/ginlane/glm_ember.git"
```


```
bundle
brew install phantomjs
bundle exec rails g glm_ember:install
```

Optoins:

* `--app-name` The Ember app name
* `--engine` If the project is a Rails engine use this and it will set the app name and put the js files under your apps namespace.
