const { readFileSync } = require("fs");

function simulate(fish_cycle_count, epochs) {
  for (let i = 0; i < epochs; i++) {
    let cycle_end = fish_cycle_count.shift();
    fish_cycle_count.push(cycle_end);
    fish_cycle_count[6] += cycle_end;
  }
  return fish_cycle_count.reduce((a, b) => a + b, 0);
}

function day06(fileName = "./data/day06.txt") {
  const input = readFileSync(fileName, "utf8")
    .split(",")
    .map((i) => parseInt(i));

  // input = [3, 4, 3, 1, 2];
  const init_cycle_count = [0, 1, 2, 3, 4, 5, 6, 7, 8].map(
    (n) => input.filter((i) => i === n).length
  );

  const part1 = simulate([...init_cycle_count], 80);
  const part2 = simulate([...init_cycle_count], 256);

  return [part1, part2];
}

module.exports = {
  day06,
};
