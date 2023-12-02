with open("./data/02-input.txt") as file:
    d = file.readlines()

def isPossible(game, valueDict):
    rounds = game.split(":")[1].split(";")
    for round in rounds:
        roundDict = tally(round)
        for color in roundDict:
            if roundDict[color] > valueDict[color]:
                return(False)
    return(True)

def tally(round):
    drawDict = {
        "blue": 0,
        "red": 0,
        "green": 0
        }
    draws = round.split(",")
    for draw in draws:
        value, color = count_color(draw)
        drawDict[color] = value
    return drawDict


def count_color(draw):
    dr = draw.strip().split(" ")
    return int(dr[0]), dr[1]


## testing
valueDict = {
    "red": 12,
    "green": 13,
    "blue": 14
}

teststr = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
teststrImpossible = "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red"

print(isPossible(teststr, valueDict))
print(isPossible(teststrImpossible, valueDict))

## solve
idSums = 0
for line in d:
    game = line.strip()
    gameID = int(game.split(":")[0][5:8])
    if isPossible(game, valueDict):
        idSums += gameID

print(idSums)

## Part 2
from math import prod

def maxNeeded(game):
    rounds = game.split(":")[1].split(";")
    gameDict = {
        "blue": 0,
        "red": 0,
        "green": 0
        }
    for round in rounds:
        roundDict = tally(round)
        for color in roundDict:
            gameDict[color] = max([gameDict[color], roundDict[color]])

    return(gameDict)

powerSum = 0
for line in d:
    game = line.strip()
    gameID = int(game.split(":")[0][5:8])
    maxValues = maxNeeded(game)
    powerSum += prod(maxValues.values())
print(powerSum)
    