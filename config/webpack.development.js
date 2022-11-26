const path = require("path");
module.exports = {
    mode: "development",
    output: {
        filename: "bundle.js",
    },
    devServer: {
        historyApiFallback: true,
        static: ["src/assets"],
        open: true,
        compress: true,
        hot: true,
        port: 3000,
    },
    module: {
        rules: [
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [
                    {
                        loader: "elm-webpack-loader",
                        options: {
                            debug: true,
                        },
                    },
                ],
            },
            {
                test: /\.(sa|sc|c)ss$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [
                    "style-loader",
                    "css-loader",
                    {
                        loader: "postcss-loader",
                        options: {
                            postcssOptions: {
                                plugins: [
                                    require("tailwindcss")(
                                        path.resolve(
                                            __dirname,
                                            "../tailwind.config.js"
                                        )
                                    ),
                                    require("autoprefixer"),
                                ],
                            },
                        },
                    },
                    "sass-loader",
                ],
            },
        ],
    },
};
