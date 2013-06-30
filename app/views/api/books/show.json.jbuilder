json.id @book.id
json.name @book.title
json.year @book.year
json.authors @book.author
json.isbn @book.isbn
json.pages @book.pages
if @book.image
  json.image @book.image.file
end
json.tags @book.tag_list
if [*5..30].sample.even?
  json.availible = true
else
  json.availible = false
  json.wait_queue = User.scoped.map(&:login)
end
json.pages = @book.pages
json.comments @book.comments, :id, :text, :user_id, :book_id
