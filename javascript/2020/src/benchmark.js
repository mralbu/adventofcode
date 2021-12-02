const Benchmark = require("benchmark");
const { day01 } = require("../src/day01.js");
const { day02 } = require("../src/day02.js");

let suite = new Benchmark.Suite();

suite
  .add("Day01", function () {
    day01();
  })
  .add("Day02", function () {
    day02();
  })
  .on("cycle", function (event) {
    console.log(event.target.toString());
  })
  .run({ async: true });
