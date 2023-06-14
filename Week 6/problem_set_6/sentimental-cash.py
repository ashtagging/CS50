from cs50 import get_float


def main():
    while True:
        dollars = get_float("Change owed: ")
        if dollars >= 0:
            break

    cents = round(dollars * 100)
    coins = 0

    coins += cents // 25  # Quarters
    cents %= 25

    coins += cents // 10  # Dimes
    cents %= 10

    coins += cents // 5   # Nickels
    cents %= 5

    coins += cents        # Pennies

    print(coins)


if __name__ == "__main__":
    main()