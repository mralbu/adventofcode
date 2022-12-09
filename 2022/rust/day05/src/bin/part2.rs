use day05::part2;
use std::fs;

fn main() {
    let file = fs::read_to_string("./input.txt").unwrap();
    println!("Part2: {}", part2(&file));
}