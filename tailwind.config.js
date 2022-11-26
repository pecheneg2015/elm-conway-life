const theme = require("tailwindcss/defaultTheme");

module.exports = {
    content: ["./src/**/*.{html,js,elm}"],
    theme: {
        ...theme,
        extend: {},
    },
    variants: {
        extend: {},
    },
    plugins: [],
};
