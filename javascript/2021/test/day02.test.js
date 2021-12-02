const { part1, part2, day02 } = require("../src/day02.js");

test("day01", () => {
  let sample = [
    "forward 5",
    "down 5",
    "forward 8",
    "up 3",
    "down 8",
    "forward 2",
  ];
  expect(part1(sample)).toBe(150);
  expect(part2(sample)).toBe(900);
  expect(day02()).toEqual([1690020, 1408487760]);
});
