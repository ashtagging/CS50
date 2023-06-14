import re
import math


def compute_readability(text):
    words = len(text.split())
    sentences = len(re.findall(r'[.!?]', text))
    letters = len(re.findall(r'[a-zA-Z]', text))

    L = (letters / words) * 100
    S = (sentences / words) * 100

    index = round(0.0588 * L - 0.296 * S - 15.8)

    if index >= 16:
        return "Grade 16+"
    elif index < 1:
        return "Before Grade 1"
    else:
        return f"Grade {index}"


def main():
    text = input("Text: ")
    print(compute_readability(text))

if __name__ == "__main__":
    main()