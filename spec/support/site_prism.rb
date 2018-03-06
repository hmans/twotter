module PageObjects
  class Post < SitePrism::Section
    element :meta, '.post-meta'
    element :body, '.post-body'
  end

  class PostsSection < SitePrism::Section
    sections :posts, Post, 'article.post'
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
