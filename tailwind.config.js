module.exports = {
    content: [
        './app/views/**/*.html.erb',
        './app/helpers/**/*.rb',
        './app/assets/stylesheets/**/*.css',
        './app/javascript/**/*.js'
    ],
    theme: {
        extend: {
        fontFamily: {
        inter: ['Inter', 'sans-serif'],
        },
    },
    },
    daisyui: {
        themes: [{
            mytheme: {
                "primary": "#D82028",
                "secondary": "#F000B8",
                "accent": "#37CDBE",
                "neutral": "#3D4451",
                "base-100": "#FFFFFF",
                "info": "#3ABFF8",
                "success": "#36D399",
                "warning": "#FBBD23",
                "error": "#F87272",
            },
        },],
    },
    plugins: [require("@tailwindcss/typography"), require("daisyui")],
}
