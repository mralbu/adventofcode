use day05::part1;
use std::fs;

fn main() {
    let file = fs::read_to_string("./input.txt").unwrap();
    println!("Part1: {}", part1(&file));
}