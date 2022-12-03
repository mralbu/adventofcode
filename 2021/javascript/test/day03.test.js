const { part1, part2, day03 } = require("../src/day03.js");

test("day03", () => {
  let sample = [
    "00100",
    "11110",
    "10110",
    "10111",
    "10101",
    "01111",
    "00111",
    "11100",
    "10000",
    "11001",
    "00010",
    "01010",
  ];
  expect(part1(sample)).toBe(198);
  expect(part2(sample)).toBe(230);
  expect(day03()).toEqual([3549854, 3765399]);
});
