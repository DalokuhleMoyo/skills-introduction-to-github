import random


def play_game() -> None:
    print("Welcome to the Number Guessing Game!")
    print("I'm thinking of a number between 1 and 100.")

    secret_number = random.randint(1, 100)
    attempts = 0

    while True:
        guess_str = input("Enter your guess (or 'q' to quit): ").strip()

        if guess_str.lower() == "q":
            print(f"You quit the game. The number was {secret_number}.")
            break

        if not guess_str.isdigit():
            print("Please enter a valid number.")
            continue

        guess = int(guess_str)
        attempts += 1

        if guess &lt; 1 or guess &gt; 100:
            print("Your guess is out of bounds. Please guess between 1 and 100.")
        elif guess &lt; secret_number:
            print("Too low, try again.")
        elif guess &gt; secret_number:
            print("Too high, try again.")
        else:
            print(f"Congratulations! You guessed the number {secret_number} in {attempts} attempts.")
            break


def main() -> None:
    while True:
        play_game()
        again = input("Play again? (y/n): ").strip().lower()
        if again != "y":
            print("Thanks for playing. Goodbye!")
            break


if __name__ == "__main__":
    main()