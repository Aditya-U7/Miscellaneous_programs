'''

Author: Aditya Upadhye

This is a simple implementation of the d'Hondt method.

'''


no_of_seats = int(input("Enter the number of seats: \n"))  
no_of_parties = int(input("Enter the number of parties:\n"))
party_votes = {}
constituency_seats = {}
cur_party_quotient = {}
cur_party_div = {}
regional_seats_alloc = {}
seats_allocated_count = 0


for i in range(no_of_parties):
    party_name = input("Enter the party name: ")
    total_votes = int(input("Enter the total party votes: "))
    constituency_seats_won = int(input("Enter the total constituency seats won: "))
    party_votes[party_name] = total_votes
    constituency_seats[party_name] = constituency_seats_won
    cur_party_quotient[party_name] = total_votes
    cur_party_div[party_name] = constituency_seats_won
    regional_seats_alloc[party_name] = 0


for i in range(1, no_of_seats + 1):

    for key, value in cur_party_div.items():
        cur_party_div[key] = (regional_seats_alloc[key] + constituency_seats[key]) + 1

        cur_party_quotient[key] = party_votes[key] / cur_party_div[key]

    print(cur_party_div)
    print(cur_party_quotient)

    max_val_key = []
    max_val = max(sorted(cur_party_quotient.values()))
    flag = False

    #print(max_val) For printing the maximum quotient of this round. Parties having this value will get allocated a seat.

    for key, value in cur_party_quotient.items():
        if value >= max_val:

            max_val_key.append(key)

    for item in max_val_key:

        regional_seats_alloc[item] += 1
        seats_allocated_count += 1       

    if flag:
        break


print("\n\nSeat allocation is as follows for specific region:\n")    

print("\nRegional seats: \n")
for key, value in regional_seats_alloc.items():
    print(key, "has got", regional_seats_alloc[key], "seat(s).")

print("\n\nTotal seats: \n")
for key, value in regional_seats_alloc.items():
    print(key, "has got", constituency_seats[key] + regional_seats_alloc[key], "seat(s).")


