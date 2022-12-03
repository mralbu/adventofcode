const { readInput } = require("./utils.js");

function day01(fileName = "./data/day01.txt") {
  const measurements = readInput(fileName)
    .split("\n")
    .map((line) => parseInt(line));

  return [part1(measurements), part2(measurements)];
}

function part1(measurements) {
  let count = 0;
  for (let i = 1; i < measurements.length; i++) {
    measurements[i] - measurements[i - 1] > 0 && count++;
  }
  return count;
}

function part2(measurements) {
  let count = 0;
  for (let i = 1; i < measurements.length - 1; i++) {
    measurements.slice(i, i + 3).reduce((a, b) => a + b) -
      measurements.slice(i - 1, i + 2).reduce((a, b) => a + b) >
      0 && count++;
  }
  return count;
}

module.exports = {
  part1,
  part2,
  day01,
};
