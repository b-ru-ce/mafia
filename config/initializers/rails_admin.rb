# -*- encoding : utf-8 -*-
# RailsAdmin config file. Generated on December 19, 2013 13:43
# See github.com/sferik/rails_admin for more informations

RailsAdmin.config do |config|

  config.model PhotoGallery do
    navigation_label 'Контент'
    weight -1
    nestable_list({ position_field: :sort })

    configure :photos do
      visible true
    end

    list do
      field :title
      field :text
      field :date
    end

    show do
      field :id
      field :title
      field :text
      field :date
      field :created_at
      field :updated_at
    end

    edit do
      group :main do
        label "Главная инфомация"
        field :title
        field :text
        field :date
        field :photos
      end

      group :seo do
        active false
        label 'SEO оптимизация'
        field :title_of_window do
          help 'Оставьте это поле пустым, если хотите оставить заголовок по умолчанию'
        end
        field :meta do
          help 'Оставьте это поле пустым, если хотите оставить мета теги по умолчанию'
        end
      end

    end
  end

  config.model Photo do
    visible false
    navigation_label 'Контент'
    weight -1
    nestable_list({ position_field: :sort })

    list do
      field :photo_gallery
      field :image
      field :main
    end

    show do
      field :id
      field :photo_gallery
      field :image
      field :description
      field :main
      field :created_at
      field :updated_at
    end

    edit do
      field :image
      field :description
      field :main
      field :sort
    end
  end
  config.model Slide do
    navigation_label 'Контент'
    weight -1
    nestable_list({ position_field: :sort })

    list do
      field :title
      field :image
      #field :url
    end

    show do
      field :id
      field :title
      field :image
      #field :url
      #field :text
      field :created_at
      field :updated_at
    end

    edit do
      field :title
      field :image
      #field :url
      #field :text, :ck_editor
    end
  end

  config.model Category do
    navigation_label 'Контент'
    weight -1
    nestable_list({ position_field: :sort })

    list do
      field :title
      field :articles
    end

    edit do
      field :title
      field :articles
    end

    show do
      field :id
      field :title
      field :articles
      field :created_at
      field :updated_at
    end
  end


  config.model Article do
    navigation_label 'Контент'
    weight -1

    list do
      field :categories
      field :date
      field :title
      field :short_text
      field :usefull

    end

    edit do
      group :main do
        label "Главная инфомация"
        field :categories
        field :title
        field :date
        field :short_text
        field :text, :ck_editor
        field :image
        field :usefull
      end

      group :seo do
        active false
        label 'SEO оптимизация'
        field :title_of_window do
          help 'Оставьте это поле пустым, если хотите оставить заголовок по умолчанию'
        end
        field :meta do
          help 'Оставьте это поле пустым, если хотите оставить мета теги по умолчанию'
        end
      end

    end

    show do
      field :id
      field :categories
      field :date
      field :title
      field :image
      field :short_text
      field :text
      field :usefull
      field :title_of_window
      field :created_at
      field :updated_at
    end
  end

  config.model Page do
    weight -4
    navigation_label 'Контент'
    nestable_tree({
                      position_field: :sort,
                      max_depth: 2
                  })

    list do
      field :title
      field :show_in_menu
    end

    show do
      field :id
      field :title
      field :text
      field :alias
      field :created_at
      field :updated_at
    end

    edit do
      group :main do
        label "Главная инфомация"
        field :title
        field :text, :ck_editor
      end

      group :spec do
        #active false
        label "Служебная информация"
        field :show_in_menu
        field :purpose, :enum do
          enum do
            [ ['Главная', '/'] , ['Новости', '/news'], ['Каталог', '/catalog'],  ['Галерея', '/gallery'], ['О компании', '/about'], ['Отзывы', '/reviews'], ['Контакты', '/contacts'], ['Портфолио', '/portfolio'], ['Услуги', '/services'], ['Рейтинг', '/rating'] ]
          end
        end

      end


      group :seo do
        active false
        label 'SEO оптимизация'
        field :title_of_window do
          help 'Оставьте это поле пустым, если хотите оставить заголовок по умолчанию'
        end
        field :meta do
          help 'Оставьте это поле пустым, если хотите оставить мета теги по умолчанию'
        end
      end

    end



  end



  config.actions do
    # root actions
    dashboard                     # mandatory
                                  # collection actions
    index                         # mandatory
    new
    export
    history_index
    bulk_delete
                                  # member actions
    show
    edit
    delete
    history_show
    show_in_app

    # Add the nestable action for configured models
    nestable
  end

  ################  Global configuration  ################
  config.authorize_with :cancan

  # Set the admin name here (optional second array element will appear in red). For example:
  config.main_app_name = ['Site', 'Admin']
  # or for a more dynamic name:
  # config.main_app_name = Proc.new { |controller| [Rails.application.engine_name.titleize, controller.params['action'].titleize] }

  # RailsAdmin may need a way to know who the current user is]
  config.current_user_method { current_user } # auto-generated

  # If you want to track changes on your models:
  config.audit_with :history, 'MyConfig'

  # Or with a PaperTrail: (you need to install it first)
  #config.audit_with :paper_trail, 'MyConfig'

  # Display empty fields in show views:
  # config.compact_show_view = false

  # Number of default rows per-page:
  # config.default_items_per_page = 20

  # Exclude specific models (keep the others):
  config.excluded_models = [Ckeditor::Asset, Ckeditor::Picture, Ckeditor::AttachmentFile, ArticlesCategories, GameRole, GameRoleType]

  # Include specific models (exclude the others):
  # config.included_models = []

  # Label methods for model instances:
  # config.label_methods << :description # Default is [:name, :title]


  ################  Model configuration  ################

  # Each model configuration can alternatively:
  #   - stay here in a `config.model 'ModelName' do ... end` block
  #   - go in the model definition file in a `rails_admin do ... end` block

  # This is your choice to make:
  #   - This initializer is loaded once at startup (modifications will show up when restarting the application) but all RailsAdmin configuration would stay in one place.
  #   - Models are reloaded at each request in development mode (when modified), which may smooth your RailsAdmin development workflow.
  # Now you probably need to tour the wiki a bit: https://github.com/sferik/rails_admin/wiki
  # Anyway, here is how RailsAdmin saw your application's models when you ran the initializer:

  config.model MyConfig do
    navigation_label 'Общее'
    weight -2

    list do
      field :key_ru
      field :value
    end

    show do
      field :id
      field :key do
        visible do
          bindings[:view]._current_user.role?('superadmin')
        end
      end
      field :key_ru
      field :value
      field :created_at
      field :updated_at
    end

    edit do
      field :key do
        visible do
          bindings[:view]._current_user.role?('superadmin')
        end
      end
      field :key_ru do
        visible do
          bindings[:view]._current_user.role?('superadmin')
        end
      end
      field :value
    end
  end

  config.model User do
    navigation_label 'Общее'
    weight 1

    edit do
      field :role
      field :email
      field :password
      field :password_confirmation
    end
  end

  config.model Role do
    navigation_label 'Общее'
    weight 0
  end

  config.model Member do
    navigation_label "Рейтинг"
    weight -1

    object_label_method do
      :custom_label_member
    end

    list do
      field :id
      field :name
      field :nick
    end

    show do
      field :id
      field :name
      field :nick
      field :gender
      field :phone
      field :vk
      field :email
      field :birthday
      field :created_at
      field :updated_at
    end

    edit do
      field :name
      field :nick
      field :gender, :enum do
        enum do
          [ ['г-н', 'г-н'] , ['г-жа', 'г-жа'] ]
        end
      end
      field :phone
      field :vk
      field :email
      field :birthday
    end
  end

  config.model Game do
    navigation_label "Рейтинг"
    configure :gamers do
      visible true
    end

    list do
      field :date
      field :game_role_type
    end

    show do
      field :date
      field :game_role_type
      field :gamers
      field :created_at
      field :updated_at
    end

    edit do
      field :date
      field :game_role_type
      field :gamers
    end
  end

  config.model Gamer do
    navigation_label "Рейтинг"
    visible false

    object_label_method do
      :custom_label_gamer
    end

    list do
      field :number
      field :member
      field :game_role
      field :guess_2
      field :guess_3
    end

    show do
      field :number
      field :member
      field :game_role
      field :guess_2
      field :guess_3
      field :created_at
    end

    edit do
      field :number
      field :member
      field :game_role
      field :first_die
      field :guess_2
      field :guess_3
    end
  end

  def custom_label_gamer
    "Игрок №#{self.number}"
  end

  def custom_label_member
    "#{self.gender} #{self.nick}"
  end
end
