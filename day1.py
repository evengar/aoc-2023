import numpy as np

with open("./data/01-input.txt") as f:
    d = f.readlines()

def get_calibration_value(string):
    numbers = np.arange(10).astype(str)
    letters = np.array(list(string))
    is_number = np.in1d(letters, numbers)
    str_num = letters[is_number]
    return int(str_num[0] + str_num[-1])

calibration_value = 0
for line in d:
    calibration_value += get_calibration_value(line.strip())

print(calibration_value)

def string_to_numbers(string):
    words = {
        "one": "1",
        "two": "2",
        "three": "3",
        "four": "4",
        "five": "5",
        "six": "6",
        "seven": "7",
        "eight": "8",
        "nine": "9"
    }
    outputstr = ""
    i = 0
    while i < len(string):
        word_found = False
        for word in words:
            potential_word = string[i:i+len(word)]
            if potential_word == word:
                outputstr += words[potential_word]
                #i += len(word)
                word_found = True
                break
        if not word_found:
            outputstr += string[i]
        i += 1
    return outputstr


# test with example input:
# from this I learned words can overlap! and fixed the function
# ex = ["two1nine",
#       "eightwothree",
#       "abcone2threexyz",
#       "xtwone3four",
#       "4nineeightseven2",
#       "zoneight234",
#       "7pqrstsixteen"
#     ]

# for line in ex:
#     print(string_to_numbers(line.strip()))


new_calibration_value = 0
for line in d:
    new_calibration_value += get_calibration_value(string_to_numbers(line.strip()))

print(new_calibration_value)
