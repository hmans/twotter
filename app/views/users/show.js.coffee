$('#load_more').replaceWith('<%= j render "posts/posts_with_paginator", posts: @posts %>')
