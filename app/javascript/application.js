// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

function renderTurnstileIfReady() {
    const el = document.querySelector(".cf-turnstile")
    if (!el) return

    // Avoid double-rendering if already initialized
    if (el.querySelector("iframe")) return

    const siteKey = el.dataset.sitekey
    if (!siteKey) return

    window.turnstile.render(el, { sitekey: siteKey })
}

document.addEventListener("turbo:load", function () {
    const hasWidget = document.querySelector(".cf-turnstile")
    if (!hasWidget) return

    if (window.turnstile && typeof window.turnstile.ready === "function") {
        window.turnstile.ready(renderTurnstileIfReady)
    } else {
        // Fallback: wait until the Turnstile script attaches to window
        const interval = setInterval(() => {
            if (window.turnstile && typeof window.turnstile.ready === "function") {
                clearInterval(interval)
                window.turnstile.ready(renderTurnstileIfReady)
            }
        }, 50)
        // Optional safety timeout
        setTimeout(() => clearInterval(interval), 5000)
    }
})
