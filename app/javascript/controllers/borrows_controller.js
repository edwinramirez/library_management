import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {}

  create(e) {
    const book_id = e.target.dataset.bookId
    const user_id = e.target.dataset.userId
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch(`/borrows`, {
      method: 'POST', // *GET, POST, PUT, DELETE, etc.
      mode: 'cors', // no-cors, *cors, same-origin
      cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
      credentials: 'same-origin', // include, *same-origin, omit
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({ book_id: book_id, user_id: user_id }) // body data type must match
      // "Content-Type" header
    })
        .then(response => response.json())
        .then(data => {
          alert(data.message)
        })
  }
  destroy(e) {
    const id = e.target.dataset.id
    const csrfToken = document.querySelector("[name='csrf-token']").content

    fetch(`/borrow/${id}`, {
      method: 'DELETE', // *GET, POST, PUT, DELETE, etc.
      mode: 'cors', // no-cors, *cors, same-origin
      cache: 'no-cache', // *default, no-cache, reload, force-cache, only-if-cached
      credentials: 'same-origin', // include, *same-origin, omit
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': csrfToken
      },
      body: JSON.stringify({}) // body data type must match
      // "Content-Type" header
    })
        .then(response => response.json())
        .then(data => {
          alert(data.message)
        })
  }
}