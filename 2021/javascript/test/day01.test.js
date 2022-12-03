const { part1, part2, day01 } = require("../src/day01.js");

test("day01", () => {
  let sample = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263];
  expect(part1(sample)).toBe(7);
  expect(part2(sample)).toBe(5);
  expect(day01()).toEqual([1316, 1344]);
});
