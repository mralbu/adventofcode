const { readFileSync } = require("fs");

readInput = (fileName) => {
  return readFileSync(fileName, "utf8");
};

const average = (arr) => arr.reduce((p, c) => p + c, 0) / arr.length;

module.exports = {
  readInput,
  average,
};
