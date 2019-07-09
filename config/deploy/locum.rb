role :app, %w(hosting_mafia-kirov@cobalt.locum.ru)
role :web, %w(hosting_mafia-kirov@cobalt.locum.ru)
role :db, %w(hosting_mafia-kirov@cobalt.locum.ru)

set :ssh_options, forward_agent: true
set :rails_env, :production
