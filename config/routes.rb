GlmEmber::Engine.routes.draw do
  mount Teaspoon::Engine => "/teaspoon"
  mount QUnit::Rails::Engine => "/qunit"
end
