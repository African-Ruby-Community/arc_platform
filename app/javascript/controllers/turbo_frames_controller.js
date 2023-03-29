import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        if (this.element.id.includes("chapter-modal")) {
            window.location.href = "#" + this.element.id
        }
    }

    disconnect() {
        if (this.element.id.includes("chapter-modal")) {
            window.location.href = "#"
        }
    }
}
