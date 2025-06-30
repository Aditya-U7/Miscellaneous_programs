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
   characters = random.sample(mixed_characters, random.randint(12, 16))
   return characters

def generate_character(character_case):

    if character_case == 'u':
        characters = string.ascii_uppercase
    else:
        characters = string.ascii_lowercase

    pos = random.randint(0, 25)
    character = characters[pos]
    return character    

def generate_symbol():

    pos = random.randint(0, 27)
    return symbols[pos]

def least_chr_required():

    lc = generate_character('u')
    uc = generate_character('l')
    sym = generate_symbol()
    num = str(random.randint(0,9))
    sample_size = 4
    least_chrs = "".join(random.sample(lc + uc + sym + num, sample_size))
    return least_chrs

def shuffle(required_chars, rest_chars):

    pwd = "" 
    length = len(rest_chars)

    rest_chars = "".join(random.sample(rest_chars, len(rest_chars) - 4))
    pwd = rest_chars + required_chars
    pwd = "".join(random.sample(pwd, len(pwd)))

    return pwd   

least_chars = ""
least_chars = least_chr_required()
rest_chars = "".join(generate_mixed_characters())
password = shuffle(least_chars, rest_chars)
print("Length of password: ", len(password))
print("Password: ", password)


























