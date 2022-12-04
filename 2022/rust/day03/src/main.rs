use std::{fs, collections::HashSet, collections::HashMap};

fn main() {
    let data = fs::read_to_string("data.txt").unwrap();
    
    let mut priorities: HashMap<char, u32> = HashMap::new();
    for (i, char) in "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".chars().enumerate() {
        priorities.insert(char, i as u32 + 1);
    }    

    let part1: u32 = data.split("\n").collect::<Vec<&str>>().into_iter()
        .map(|rucksack| {
            let (compartment1, compartment2) = rucksack.split_at(rucksack.len() / 2);
            let compartment1_set: HashSet<u32> = compartment1.chars().map(|x| *priorities.get(&x).unwrap()).collect();
            let compartment2_set: HashSet<u32> = compartment2.chars().map(|x| *priorities.get(&x).unwrap()).collect();

            let common_item: HashSet<u32> = &compartment1_set & &compartment2_set;
            common_item.iter().sum::<u32>()
        }).sum::<u32>();

    println!("Part1 : {}", part1);

    let part2: u32 = data.split("\n").collect::<Vec<&str>>()
        .chunks(3)
        .map(|x| {
            let e1_set: HashSet<u32> = x[0].trim().chars().map(|x| *priorities.get(&x).unwrap()).collect();
            let e2_set: HashSet<u32> = x[1].trim().chars().map(|x| *priorities.get(&x).unwrap()).collect();
            let e3_set: HashSet<u32> = x[2].trim().chars().map(|x| *priorities.get(&x).unwrap()).collect();
            (&(&e1_set & &e2_set) & &e3_set).iter().sum::<u32>()
        }).sum();
    
    println!("Part2 : {:?}", part2);

}

