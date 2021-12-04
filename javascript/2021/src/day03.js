const { readInput } = require("./utils.js");

function day03(fileName = "./data/day03.txt") {
  const input = readInput(fileName).split("\n");

  return [part1(input), part2(input)];
}

function part1(input) {
  let counter = new Array(input[0].length).fill(0);

  for (line of input) {
    [...line].forEach((bit, i) => {
      bit == "1" && counter[i]++;
    });
  }
  const x = counter.map((count) => (count > input.length / 2 ? 1 : 0));
  return (
    parseInt(x.join(""), 2) * parseInt(x.map((bit) => bit ^ 1).join(""), 2)
  );
}

function most_common_bit(input, pos) {
  let counter = 0;

  for (line of input) {
    line[pos] == "1" && counter++;
  }
  return counter >= input.length / 2 ? 1 : 0;
}

function least_common_bit(input, pos) {
  return most_common_bit(input, pos) ^ 1;
}

function device_rating(input, bit_evaluation) {
  let pos = 0;
  while (input.length > 1) {
    input_candidate = input.filter(
      (line) => parseInt(line[pos]) === bit_evaluation(input, pos)
    );
    if (input_candidate.length > 1) {
      input = input_candidate;
    } else {
      break;
    }
    pos += 1;
  }
  return input[1];
}

function part2(input) {
  const oxygen_generator_rating = device_rating(input, most_common_bit);
  const co2_scrubber_rating = device_rating(input, least_common_bit);

  return (
    parseInt(oxygen_generator_rating, 2) * parseInt(co2_scrubber_rating, 2)
  );
}

module.exports = {
  part1,
  part2,
  day03,
};
