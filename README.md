== README


# Reader

Reader allows user to read faster online in color. User can select the reading speed from 5-350 words per minute. User can also chose to read black text on white background or can read in Semaphore random color theme.

You can also pause while reading.

Signup with email and create your account. Enjoy reading!

## Specifications

```
  Article
    should validate that :url cannot be empty/falsy
    should validate that :user cannot be empty/falsy
    should respond to #title
    should respond to #author
    should respond to #text
    should belong to user
    extract text from given url
    populate error if text extraction failed
    short text for displaying article
    ignore the articles without text

  User
    valid with a valid email and password

  Page
    extract text from a page

  ArticlesController
    list articles read by user
    create new article for given url

  ArticleReadingSpec
    user should be able to read article at given speed and color theme
```
