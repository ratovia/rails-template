txt = <<-TXT

************
CMS Template
************

TXT
puts txt

gem_group :test, :development do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end
gem 'safaripark'
gem 'devise'
run 'bundle install'

run 'rm -rf test'
generate 'rspec:install'
if yes?('deviseのユーザを生成する？(yss/no)')
  generate 'devise:install'
  generate 'devise user'
end
run 'rm -rf db/seeds.rb'
generate 'safaripark:install' if yes?('safariparkの管理画面生成する?(yss/no)')
run 'yarn'
run 'bundle install'
rails_command 'db:drop'
rails_command 'db:create'
rails_command 'db:migrate:reset'
rails_command 'db:seed'

if yes?('gitの初期化する？(yss/no)')
  after_bundle do
    git :init
    git add: "."
    git commit: %Q{ -m 'initialize repository' }
  end
end
