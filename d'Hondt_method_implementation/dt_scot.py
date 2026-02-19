'''

Author: Aditya Upadhye

This is a simple implementation of the d'Hondt method.

'''


no_of_seats = 7                # As there are 8 regions with 7 regional seats. Total = 56
party_votes = {'a': 135827, 'b': 72544, 'c' : 71528, 'd' : 17218, 'e': 12097}     #Enter the party names and their total votes here.
constituency_seats = {'a' : 8, 'b': 1, 'c': 1, 'd' : 0, 'e' : 0}
regional_seats_alloc = {'a' : 0, 'b': 0, 'c': 0, 'd' : 0, 'e': 0}

cur_party_div = {'a' : 8, 'b': 1, 'c': 1, 'd' : 0, 'e' : 0}
cur_party_quotient = {'a': 135827, 'b': 72544, 'c' : 71528, 'd' : 17218, 'e': 12097} 
seats_allocated_count = 0


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

        #print(cur_party_quotient) #To know the party quotient values for this round, uncomment this line.

        if seats_allocated_count == no_of_seats:
            flag = True
            break

    if flag:
        break


print("\n\nSeat allocation is as follows for specific region:\n")    

print("\nRegional seats: \n")
for key, value in regional_seats_alloc.items():
    print(key, "has got", regional_seats_alloc[key], "seat(s).")

print("\n\nTotal seats: \n")
for key, value in regional_seats_alloc.items():
    print(key, "has got", constituency_seats[key] + regional_seats_alloc[key], "seat(s).")

