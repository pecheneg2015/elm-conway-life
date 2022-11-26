const CssMinimizerPlugin = require("css-minimizer-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");
const MiniCssExtractPlugin = require("mini-css-extract-plugin");
const TerserPlugin = require("terser-webpack-plugin");
const path = require("path");

module.exports = {
    mode: "production",
    output: {
        filename: "static/js/[name]-[contenthash:8].js",
        chunkFilename: "static/js/[name]-[contenthash:8].chunk.js",
    },
    optimization: {
        minimize: true,
        minimizer: [new TerserPlugin(), new CssMinimizerPlugin()],
    },
    plugins: [
        new CopyWebpackPlugin({
            patterns: [{ from: "src/assets" }],
        }),
        new MiniCssExtractPlugin({
            filename: "static/styles/[name]-[contenthash:8].css",
            experimentalUseImportModule: true,
        }),
    ],
    module: {
        rules: [
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [
                    {
                        loader: "elm-webpack-loader",
                        options: {
                            optimize: true,
                            debug: false,
                        },
                    },
                ],
            },
            {
                test: /\.(sa|sc|c)ss$/,
                exclude: [/elm-stuff/, /node_modules/],
                use: [
                    MiniCssExtractPlugin.loader,
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
