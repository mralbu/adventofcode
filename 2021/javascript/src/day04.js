const { readInput } = require("./utils.js");

function check_win(card) {
  const idx = [...Array(card[0].length).keys()];

  return (
    idx.some((i) => card.every((line) => line[i] === -1)) ||
    idx.some((i) => card[i].every((el) => el === -1))
  );
}

function day04(fileName = "./data/day04.txt") {
  const input = readInput(fileName).split("\n\n");
  const draws = input[0].split(",").map((x) => parseInt(x));
  let cards = input.slice(1, input.length).map((x) =>
    x.split("\n").map((line) =>
      line
        .trim()
        .split(/\s+/)
        .map((x) => parseInt(x))
    )
  );

  done = new Set();
  res = [];

  for (let num of draws) {
    for (let i in cards) {
      cards[i] = cards[i].map((line) => line.map((x) => (x === num ? -1 : x)));
      if (!done.has(Number(i)) && check_win(cards[i])) {
        done.add(Number(i));
        res.push(
          num *
            cards[i]
              .map((line) => line.reduce((a, b) => a + b * (b > 0), 0))
              .reduce((a, b) => a + b, 0)
        );
      }
    }
  }
  return [res[0], res[res.length - 1]];
}

module.exports = {
  day04,
};
