anirudh = User.create(username: 'Anirudh', about:'greatest rapper alive')

anirudh.posts.create(title: "chillin", article_url: "https://www.destroyallsoftware.com/talks/wat")
anirudh.comments.create(content: "Crazy!") 

comment = Comment.find_by_content("Crazy!")

Post.find_by_title("chillin").comments << comment  
