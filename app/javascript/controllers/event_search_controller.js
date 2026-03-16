import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["query", "location", "date", "country"]
  
  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)
    
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 500)
  }
}
