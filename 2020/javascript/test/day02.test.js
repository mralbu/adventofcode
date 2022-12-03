const { day02 } = require("../src/day02.js");

test("day02", () => {
  let sample = "1-3 a: abcde\n" + "1-3 b: cdefg\n" + "2-9 c: ccccccccc";
  expect(day02(sample)).toEqual([2, 1]);
  expect(day02()).toEqual([542, 360]);
});
