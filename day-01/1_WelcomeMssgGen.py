# #Things learnt here:
# 1. input(): to take user input
# 2. print(): to display output
# 3. f-strings: to format strings with variables
# 4. capitalize(): to capitalize the first letter of a string
# 5. lower(): to convert a string to lowercase
# 6. importing modules: to use functions from other libraries (e.g., datetime ) and how to use them



#imports

from datetime import date



#User Details

user_name = (input("Please enter your name: ")).capitalize()
user_hobby = input("Please enter your hobby: ").lower()
user_color = input("Please enter your favorite color: ").lower()

#other details
today = date.today()

#Welcome Message
print("\n-- Welcome Message --")
print(f"Hello {user_name}! 👋")
print("Welcome to the world of programming! 🚀")
print(f"It's great to know that you enjoy {user_hobby}. 🎉")
print(f"Your favorite color is {user_color}! 🌈 as  of {today}")
