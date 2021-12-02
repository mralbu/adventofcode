const { readInput } = require("./utils.js");

function day01(fileName = "./data/day01.txt") {
  const lines = readInput(fileName).split("\n");
  const numbers = lines.map((line) => parseInt(line));

  return [part1(numbers), part2(numbers)];
}

function part1(numbers) {
  for (let i = 0; i < numbers.length; i++) {
    for (let j = i + 1; j < numbers.length; j++) {
      if (numbers[i] + numbers[j] === 2020) return numbers[i] * numbers[j];
    }
  }
}

function part2(numbers) {
  for (let i = 0; i < numbers.length; i++) {
    for (let j = i + 1; j < numbers.length; j++) {
      if (numbers[i] + numbers[j] >= 2020) continue;
      for (let k = j + 1; k < numbers.length; k++) {
        if (numbers[i] + numbers[j] + numbers[k] === 2020)
          return numbers[i] * numbers[j] * numbers[k];
      }
    }
  }
}

module.exports = {
  part1,
  part2,
  day01,
};
