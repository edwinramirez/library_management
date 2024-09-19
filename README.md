README

* ## Uses
    * Ruby version: 3.3.0
    * Rails version: 7.1.4
    * SQLite3 version: 1.4

* ## Setup
From your console, run
* `bundle install`,
* `rails db:create`,
* `rails db:migrate`,
* `rails db:seed` 
  * Creates 50 books
  * 1 Librarian (admin) user
  * 10 Members
  * 3 overdue borrows
  * 4 due today borrows
  * The Librarian has their email set to 'boss@library.com'
  * All users have 'password' set as their password
* `bin/dev` to start the server
* Visit `localhost:3000` in your browser

