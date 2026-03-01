import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    sitekey: String,
    size: String,
    theme: String,
  }
  static targets = ["turnstile"]

  connect() {
    this._rendered = false
    this._pollHandle = null

    // Provide sensible defaults if not specified
    this._size = this.hasSizeValue ? this.sizeValue : "flexible"
    this._theme = this.hasThemeValue ? this.themeValue : "light"

    if (!this.hasSitekeyValue || !this.sitekeyValue) {
      console.warn("Turnstile: Missing sitekey. Ensure credentials[:cloudflare_turnstile][:site_key] is set for this environment.")
    }

    this._tryRender()

    // If API not yet present, poll briefly until it's loaded
    if (!window.turnstile) {
      this._pollHandle = setInterval(() => {
        if (window.turnstile) {
          this._tryRender()
          this._clearPoll()
        }
      }, 100)
    }
  }

  disconnect() {
    this._clearPoll()
  }

  _clearPoll() {
    if (this._pollHandle) {
      clearInterval(this._pollHandle)
      this._pollHandle = null
    }
  }

  _tryRender() {
    if (this._rendered) return
    if (!this.hasTurnstileTarget) return
    if (!window.turnstile) return

    try {
      window.turnstile.render(this.turnstileTarget, {
        sitekey: this.sitekeyValue,
        size: this._size,
        theme: this._theme,
        callback: () => {
          this._enableClosestSubmitButton()
        }
      })
      this._rendered = true
      // Optional: mark element as rendered for debugging
      this.element.setAttribute("data-turnstile-rendered", "true")
    } catch (e) {
      console.error("Turnstile: render failed", e)
    }
  }

  _enableClosestSubmitButton() {
    const btn = this.closestSubmitButton
    if (btn) btn.removeAttribute("disabled")
  }

  get closestSubmitButton() {
    const form = this.element.closest("form")
    if (!form) return null
    return (
      form.querySelector("button[disabled]") ||
      form.querySelector("button[type=submit]") ||
      form.querySelector("input[type=submit]")
    )
  }
}
