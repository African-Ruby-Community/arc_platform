import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="removals"
export default class extends Controller {
  remove() {
    this.element.remove()
  }

  remove_on_click() {
    // TODO: add animation to slowly remove element.
    this.element.remove()
  }
}
