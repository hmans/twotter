module PageObjects
  class Post < SitePrism::Section
    element :meta, '.post-meta'
    element :body, '.post-body'
  end

  class PostsSection < SitePrism::Section
    sections :posts, Post, 'article.post'
  end

  class Page < SitePrism::Page
    element :flashes, 'div.flashes'
    element :navigation, 'nav[role="main"]'
  end

  class PageWithPost < Page
    section :posts_section, PostsSection, 'section.posts'
    element :title, 'h1'
  end

  class GlobalPage < PageWithPost
    set_url '/global'
  end

  class TimelinePage < PageWithPost
    set_url '/timeline'
  end

  class HomePage < Page
    set_url '/'
  end

  class RegistrationPage < SitePrism::Page
    set_url '/users/new'
    element :page_title, 'h1'

    element :name_field, 'input#user_name'
    element :full_name_field, 'input#user_full_name'
    element :email_field, 'input#user_email'
    element :password_field, 'input#user_password'
    element :password_confirmation_field, 'input#user_password_confirmation'

    def fill_form(data)
      name_field.set(data[:name])
      full_name_field.set(data[:full_name])
      email_field.set(data[:email])
      password_field.set(data[:password])
      password_confirmation_field.set(data[:password])

      click_on 'Create User'
    end
  end
end
