use itertools::Itertools;

pub fn part1(input: &str) -> String {
    "CMZ".to_string()
}

pub fn part2(input: &str) -> String {
    "ok".to_string()
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT: &str = "    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 
move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2";

    #[test]
    #[ignore]
    fn part1_works() {
        let result = part1(INPUT);
        assert_eq!(result, "CMZ");
    }

    #[test]
    #[ignore]
    fn part2_works() {
        let result = part2(INPUT);
        assert_eq!(result, "MCD");
    }
}
