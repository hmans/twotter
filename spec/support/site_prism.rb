module PageObjects
  class PostsSection < SitePrism::Section
    elements :posts, 'article.post'
  end

  class GlobalPage < SitePrism::Page
    set_url '/global'
    section :posts_section, PostsSection, 'section.posts'
  end
end
