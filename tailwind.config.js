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
        themes: ["light", {
            mytheme: {
                "primary": "#D82028",
                "primary-content": "#FFFFFF",
                "secondary": "#F000B8",
                "accent": "#37CDBE",
                "neutral": "#3D4451",
                "base-100": "#FFFFFF",
                "base-content": "#1f2937",
                "info": "#3ABFF8",
                "success": "#36D399",
                "warning": "#FBBD23",
                "error": "#F87272",
            },
        }],
        darkTheme: false,
        base: true,
        styled: true,
        utils: true,
    },
    screens: {
        xs: '576',
        sm: '640px',
        md: '768px',
        lg: '1024px',
        xl: '1280px',
        '2xl': '1536px',
    },
    plugins: [require("@tailwindcss/typography"), require("daisyui")],
}
