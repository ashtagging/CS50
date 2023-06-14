def get_height():
    while True:
        height = input("Height: ")
        if height.isdigit() and 1 <= int(height) <= 8:
            return int(height)
        else:
            print("Invalid input. Please enter a positive integer between 1 and 8.")


def print_half_pyramid(height):
    for i in range(height):
        print(' ' * (height - i - 1) + '#' * (i + 1))


# Get the height from the user
height = get_height()

# Print the half-pyramid
print_half_pyramid(height)