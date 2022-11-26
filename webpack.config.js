const { merge } = require("webpack-merge");
const commonConfig = require("./config/webpack.common");

module.exports = () => {
    const mode = process.env.NODE_ENV;
    const config = require("./config/webpack." + mode);
    return merge(commonConfig, config);
};
