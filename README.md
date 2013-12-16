
```
brew install phantomjs
bundle exec guard init
bundle exec rails g teaspoon:install --framework=qunit --coffee
bundle exec glm_ember init --app-name=AppName
```

Add or edit the following segment in the guardfile

```ruby
guard :teaspoon do
  watch(%r{app/assets/javascripts/(.+).js}) { |m| "#{m[1]}_spec" }
  watch(%r{test/javascripts/(.*)})
end
```