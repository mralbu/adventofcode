const { readInput } = require("./utils.js");

function day02(sample = readInput("./data/day02.txt")) {
  let [part1, part2] = [0, 0];

  const lines = sample.split("\n");
  const pattern = /^(\d+)-(\d+)\s+(\w):\s+(\w+)$/;

  lines.forEach((entry) => {
    let [_, low, high, targetChar, pwd] = entry.match(pattern);
    const charCounts = pwd.match(RegExp(`[${targetChar}]`, "g"))?.length;
    low = parseInt(low);
    high = parseInt(high);

    if (charCounts >= low && charCounts <= high) part1++;
    if (xor(pwd[low - 1] === targetChar, pwd[high - 1] === targetChar)) part2++;
  });

  return [part1, part2];
}

function xor(a, b) {
  return a ^ b;
}

module.exports = {
  day02,
};
