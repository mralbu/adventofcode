const Benchmark = require("benchmark");
const { day01 } = require("../src/day01.js");
const { day02 } = require("../src/day02.js");
const { day03 } = require("../src/day03.js");
const { day04 } = require("../src/day04.js");
const { day05 } = require("../src/day05.js");
const { day06 } = require("../src/day06.js");

let suite = new Benchmark.Suite();

suite
  .add("Day01", function () {
    day01();
  })
  .add("Day02", function () {
    day02();
  })
  .add("Day03", function () {
    day03();
  })
  .add("Day04", function () {
    day04();
  })
  .add("Day05", function () {
    day05();
  })
  .add("Day06", function () {
    day06();
  })
  .on("cycle", function (event) {
    console.log(
      `${event.target.name}: ${
        Math.round(event.target.stats.mean * 1e6 * 10) / 10
      } ± ${Math.round(event.target.stats.deviation * 1e6 * 10) / 10} μs`
    );
  })
  .run({ async: true });
