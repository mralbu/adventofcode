const { readInput } = require("./utils.js");

function day02(fileName = "./data/day02.txt") {
  const commands = readInput(fileName).split("\n");

  return [part1(commands), part2(commands)];
}

function part1(commands) {
  let [depth, horizontal] = [0, 0];

  for (command of commands) {
    let [key, value] = [command[0], parseInt(command.at(-1))];
    key == "u" && (depth -= value);
    key == "d" && (depth += value);
    key == "f" && (horizontal += value);

    depth = Math.max(0, depth);
  }
  return depth * horizontal;
}

function part2(commands) {
  let [aim, depth, horizontal] = [0, 0, 0];

  for (command of commands) {
    let [key, value] = [command[0], parseInt(command.at(-1))];
    key == "u" && (aim -= value);
    key == "d" && (aim += value);
    if (key == "f") {
      horizontal += value;
      depth += aim * value;
    }

    depth = Math.max(0, depth);
  }
  return depth * horizontal;
}

module.exports = {
  part1,
  part2,
  day02,
};
