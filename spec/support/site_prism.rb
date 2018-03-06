module PageObjects
  class PostsSection < SitePrism::Section
    elements :posts, 'article.post'
  end

  class PageWithPost < SitePrism::Page
    section :posts_section, PostsSection, 'section.posts'
  end

  class GlobalPage < PageWithPost
    set_url '/global'
  end

  class TimelinePage < PageWithPost
    set_url '/timeline'
  end
end
