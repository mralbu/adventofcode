const { readInput } = require("./utils.js");

function day03(sample = readInput("./data/day03.txt")) {
  let treemap = sample.split("\n");
  return [part1(treemap), part2(treemap)];
}

function count_trees(treemap, right, down) {
  let [rows, cols] = [treemap.length, treemap[1].length];
  let [r, c, ntrees] = [0, 0, 0];

  while (r <= rows - 1) {
    if (treemap[r][c] == "#") ntrees++;

    c = (c + right) % cols;
    r += down;
  }
  return ntrees;
}

function part1(treemap) {
  return count_trees(treemap, 3, 1);
}

function part2(treemap) {
  return [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2],
  ].reduce((acc, [right, down]) => acc * count_trees(treemap, right, down), 1);
}

module.exports = {
  day03,
};
