namespace :db do

  desc 'Change base'
  task :change_base => :environment do

    require 'populator'
    require 'faker'

    # something do

    mir = GameRoleType.create name: 'мирные'
    maf = GameRoleType.create name: 'мафия'

    mir.game_roles.create name: 'мирный'
    maf.game_roles.create name: 'мафия'
    mir.game_roles.create name: 'шериф'
    maf.game_roles.create name: 'дон'

    role = Role.create name: 'emcee'
    role.users.create email: 'emcee@emcee.ru', password: 'password', password_confirmation: 'password'
  end
end