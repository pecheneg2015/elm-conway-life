"use strict";

require('elm-canvas')
require('./styles.css')

const { Elm } = require("./Main");
Elm.Main.init({ flags: 6, node: document.getElementById("elm-node") });
