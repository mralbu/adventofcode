const { readFileSync } = require("fs");

line_length = ([x1, y1, x2, y2]) =>
  Math.max(Math.abs(x1 - x2), Math.abs(y1 - y2));

function coord_intersects(lines) {
  let coord_inter = new Map();

  for (let idx = 0; idx < lines.length; idx++) {
    let [x1, y1, x2, y2] = lines[idx];

    let deltax = x2 === x1 ? 0 : x2 > x1 ? 1 : -1;
    let deltay = y2 === y1 ? 0 : y2 > y1 ? 1 : -1;

    let [x, y] = [x1, y1];
    for (let _ = 0; _ <= line_length(lines[idx]); _++) {
      let k = [x, y].join();
      !coord_inter.get(k) && coord_inter.set(k, 0);
      coord_inter.set(k, coord_inter.get(k) + 1);
      x != x2 && (x += deltax);
      y != y2 && (y += deltay);
    }
  }
  //   return [...coord_inter.values()];
  return [...coord_inter.values()].map((x) => x > 1).reduce((a, b) => a + b, 0);
}

function day05(fileName = "./data/day05.txt") {
  const input = readFileSync(fileName, "utf8")
    .split("\n")
    .map((l) => l.split(/,|->/).map((i) => parseInt(i.trim())));

  let hv_lines = input.filter(([x1, y1, x2, y2]) => x1 == x2 || y1 == y2);

  const part1 = coord_intersects(hv_lines);
  const part2 = coord_intersects(input);

  return [part1, part2];
}

module.exports = {
  day05,
};
