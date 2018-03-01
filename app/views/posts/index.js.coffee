$('#load_more').replaceWith('<%= j render "posts_with_paginator", posts: @posts %>')
