use std::fs;
use regex::Regex;
use std::collections::HashSet;

fn main() {
    let data = fs::read_to_string("data.txt").unwrap();
    let re = Regex::new(r"^(\d+)-(\d+),(\d+)-(\d+)$").unwrap();

    let part1 = data.split("\n")
        .map(|x| {
            let caps = re.captures(x).unwrap();
            let l1 = caps.get(1).map_or("", |m| m.as_str()).parse::<u32>().unwrap();
            let u1 = caps.get(2).map_or("", |m| m.as_str()).parse::<u32>().unwrap();
            let l2 = caps.get(3).map_or("", |m| m.as_str()).parse::<u32>().unwrap();
            let u2 = caps.get(4).map_or("", |m| m.as_str()).parse::<u32>().unwrap();
            ((l1 <= l2) && (u1 >= u2)) || ((l2 <= l1) && (u2 >= u1))
        })
        .filter(|b| *b)
        .count();

    println!("Part1: {:?}", part1);

    let part2 = data.split("\n")
        .map(|x| {
            let caps = re.captures(x).unwrap();
            let l1 = caps.get(1).map_or("", |m| m.as_str()).parse::<u32>().unwrap();
            let u1 = caps.get(2).map_or("", |m| m.as_str()).parse::<u32>().unwrap();
            let l2 = caps.get(3).map_or("", |m| m.as_str()).parse::<u32>().unwrap();
            let u2 = caps.get(4).map_or("", |m| m.as_str()).parse::<u32>().unwrap();
            let pair_1 = (l1..=u1).collect::<HashSet<u32>>();
            let pair_2 = (l2..=u2).collect::<HashSet<u32>>();
            (&pair_1 & &pair_2).iter().count() > 0
        })
        .filter(|b| *b)
        .count();

    println!("Part2: {:?}", part2);

}