# warming up with 2020 day 2

with open("data/2020-02-input.txt") as file:
    input1 = file.readlines()

valid = 0
for line in input1:
    line_strp = line.strip()
    numrange, letter, string = line_strp.split()
    nums = numrange.split("-")
    let = letter.replace(":", "")
    n_char = string.count(let)
    if n_char >= int(nums[0]) and n_char <= int(nums[1]):
        valid += 1

print(valid)

# part 2
valid = 0
for line in input1:
    line_strp = line.strip()
    numrange, letter, string = line_strp.split()
    nums = numrange.split("-")
    let = letter.replace(":", "")
    pos1 = int(nums[0]) - 1
    pos2 = int(nums[1]) - 1
    valid1 = string[pos1] == let
    valid2 = string[pos2] == let
    #print(pos1, pos2, let)

    if valid1 + valid2 == 1:
        valid += 1
        #print(string, "is valid")
    #else:
        #print(string, "is invalid")
print(valid)