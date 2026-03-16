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

// Dismissible alerts (close button + optional auto-dismiss)
document.addEventListener("turbo:load", function () {
    // Handle manual close
    document.querySelectorAll('[data-close-alert]')?.forEach((btn) => {
        btn.addEventListener('click', (e) => {
            const el = e.currentTarget.closest('.alert')
            if (el) el.remove()
        })
    })

    // Handle auto-dismiss
    document.querySelectorAll('.alert[data-dismiss-after]')?.forEach((alert) => {
        const ms = parseInt(alert.getAttribute('data-dismiss-after'), 10)
        if (!Number.isNaN(ms) && ms > 0) {
            setTimeout(() => {
                // Ensure element still exists
                if (alert && alert.parentNode) {
                    alert.remove()
                }
            }, ms)
        }
    })
})
