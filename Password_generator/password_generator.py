'''

Author: Aditya Upadhye

A simple password generator program for creating a password with a length ranging from 12 to 16 characters. It contains at least one lower case, upper case, symbol and a digit.

'''

import string
import random


symbols = '"~!@#$%^&*()_+{}":<>?,./[]-=`'
numbers = "0123456789"

def generate_mixed_characters():

   mixed_characters = string.ascii_lowercase + string.ascii_uppercase + symbols + numbers
   min_mixed_char_length = 12
   max_mixed_char_length = 16
   characters = random.sample(mixed_characters, random.randint(min_mixed_char_length, max_mixed_char_length))
   return characters

def generate_character(character_case):

    if character_case == 'u':
        characters = string.ascii_uppercase
    else:
        characters = string.ascii_lowercase
    char_first_index = 0
    char_last_index = 25
    index_of_char_selected = random.randint(char_first_index, char_last_index)
    return characters[index_of_char_selected]    

def generate_symbol():
    
    symbol_first_index = 0
    symbol_last_index = 28
    index_of_symbol_selected = random.randint(symbol_first_index, symbol_last_index)
    return symbols[index_of_symbol_selected]

def least_chr_required():

    upper_case = generate_character('u')
    lower_case = generate_character('l')
    symbol = generate_symbol()
    number_first_value = 0
    number_last_value = 9
    number = str(random.randint(number_first_value, number_last_value))
    sample_size = 4
    least_chrs = "".join(random.sample(lower_case + upper_case + symbol + number, sample_size))
    return least_chrs

def shuffle(required_chars, rest_chars):

    pwd = "" 
    length = len(rest_chars)
    rest_chars = "".join(random.sample(rest_chars, len(rest_chars) - len(required_chars)))
    pwd = rest_chars + required_chars
    pwd = "".join(random.sample(pwd, len(pwd)))

    return pwd   

least_chars = ""
least_chars = least_chr_required()
rest_chars = "".join(generate_mixed_characters())
password = shuffle(least_chars, rest_chars)
print("Length of password: ", len(password))
print("Password: ", password)
