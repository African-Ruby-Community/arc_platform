import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "card", "empty", "count"]

  filter() {
    const query = this.inputTarget.value.trim().toLowerCase()
    let visible = 0

    this.cardTargets.forEach(card => {
      const text = card.dataset.searchText.toLowerCase()
      const match = !query || text.includes(query)
      card.style.display = match ? "" : "none"
      if (match) visible++
    })

    if (this.hasEmptyTarget) {
      this.emptyTarget.style.display = visible === 0 ? "" : "none"
    }

    if (this.hasCountTarget) {
      this.countTarget.textContent = `${visible} project${visible === 1 ? "" : "s"}`
    }
  }

  clear() {
    this.inputTarget.value = ""
    this.filter()
    this.inputTarget.focus()
  }
}
