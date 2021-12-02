const { part1, part2, day01 } = require("../src/day01.js");

test("day01", () => {
  let sample = [1721, 979, 366, 299, 675, 1456];
  expect(part1(sample)).toBe(514579);
  expect(part2(sample)).toBe(241861950);
  expect(day01("./data/day01.txt")).toEqual([876459, 116168640]);
});
