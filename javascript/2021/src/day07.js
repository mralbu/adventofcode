const { readFileSync } = require("fs");
const { mean, median, abs } = require("mathjs");

function pa_sum(d) {
  return (d * (1 + d)) / 2;
}

function day07(fileName = "./data/day07.txt") {
  let input = readFileSync(fileName, "utf8")
    .split(",")
    .map((i) => parseInt(i));
  //   input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14];
  m1 = Math.round(median(input));
  m2 = mean(input);
  m2_floor = Math.floor(m2);
  m2_ceil = Math.ceil(m2);

  const part1 = input.map((x) => Math.abs(x - m1)).reduce((a, b) => a + b, 0);
  const part2_floor = input
    .map((x) => pa_sum(Math.abs(x - m2_floor)))
    .reduce((a, b) => a + b, 0);
  const part2_ceil = input
    .map((x) => pa_sum(Math.abs(x - m2_ceil)))
    .reduce((a, b) => a + b, 0);

  const part2 = Math.min(part2_ceil, part2_floor);

  return [part1, part2];
}

module.exports = {
  day07,
};
