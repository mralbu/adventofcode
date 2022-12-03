use std::fs;

fn main() {
    let games = fs::read_to_string("data.txt").unwrap();

    let part1: u32 = games.lines()
        .map(|game| match game {
            "A X" => 4,
            "A Y" => 8,
            "A Z" => 3,
            "B X" => 1,
            "B Y" => 5,
            "B Z" => 9,
            "C X" => 7,
            "C Y" => 2,
            "C Z" => 6,
            _ => 0,
        }).sum();

    println!("Part 1: {}", part1);

    let part2: u32 = games.lines()
        .map(|game| match game {
            "A X" => 3,
            "A Y" => 4,
            "A Z" => 8,
            "B X" => 1,
            "B Y" => 5,
            "B Z" => 9,
            "C X" => 2,
            "C Y" => 6,
            "C Z" => 7,
            _ => 0,
        }).sum();

    println!("Part 2: {}", part2);
}
