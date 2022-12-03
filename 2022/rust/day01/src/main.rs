use std::fs;

fn main(){
    let data = fs::read_to_string("data-day01.txt").unwrap();

    let part1: u32 = data.split("\n\n")
        .map(|block| block.trim()
            .split("\n")
            .map(|x| x.parse::<u32>().unwrap())
            .sum::<u32>()
        )
        .max()
        .unwrap();

    println!("Part 1: {}", part1);

    let mut block_sums: Vec<u32> = data.split("\n\n")
        .map(|block| block.trim()
            .split("\n")
            .map(|x| x.parse::<u32>().unwrap())
            .sum::<u32>()
        ).collect();

    block_sums.sort();

    let part2: u32 = block_sums.iter().rev().take(3).sum();

    println!("Part 2: {}", part2);
}