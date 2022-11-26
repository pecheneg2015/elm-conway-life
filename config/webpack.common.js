const path = require("path");
const { CleanWebpackPlugin } = require("clean-webpack-plugin");
const HTMLWebpackPlugin = require("html-webpack-plugin");

module.exports = {
    entry: {
        main: path.resolve(__dirname, "../src/index.js"),
    },
    resolve: {
        modules: [path.join(__dirname, "src"), "node_modules"],
        extensions: [".js", ".elm", ".scss", ".css", ".png", ".svg", ".jpg"],
    },
    output: {
        path: path.join(__dirname, "../dist"),
        publicPath: "auto",
    },
    plugins: [
        new CleanWebpackPlugin({
            root: __dirname,
            exclude: [],
            verbose: true,
            dry: false,
        }),
        new HTMLWebpackPlugin({
            title: "Conway's Game of Life",
            template: path.resolve(__dirname, "../src/index.html"),
            filename: "index.html",
        }),
    ],
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: "babel-loader",
                },
            },
            {
                test: /\.(png|jpg|gif|webp)$/,
                exclude: [/elm-stuff/, /node_modules/],
                type: "asset/resource",
            },
            {
                test: /.(svg|ttf|otf|eot|woff(2)?)(\?[a-z0-9]+)?$/,
                exclude: [/elm-stuff/, /node_modules/],
                type: "asset",
                parser: {
                    dataUrlCondition: {
                        maxSize: 8 * 1024, // 4kb
                    },
                },
            },
        ],
    },
};
