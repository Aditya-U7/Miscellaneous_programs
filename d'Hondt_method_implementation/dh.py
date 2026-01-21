'''

Author: Aditya Upadhye

This is a simple implementation of the d'Hondt method.

'''


no_of_seats = 8
party_votes = {'a': 10000, 'b': 6000, 'c' : 1500}     #Enter the party names and their total votes here.
seats_alloc = {}
cur_party_quotient = {'a': 10000, 'b': 6000, 'c' : 1500}     #Enter the party names and their total votes again. 
seats_allocated_count = 0

for i in range(1, no_of_seats + 1):
    max_val_key = []
    max_val = max(sorted(cur_party_quotient.values()))
    flag = False

    #print(max_val) For printing the maximum dividend of this round. Parties having this value will get allocated a seat.

    for key, value in cur_party_quotient.items():
        if value >= max_val:

            max_val_key.append(key)

    for item in max_val_key:
        try:
            seats_alloc[item] += 1
        except:
            seats_alloc[item] = 1

        seats_allocated_count += 1

        #print(cur_party_quotient) #To know the party dividend values for this round, uncomment this line.

        if seats_allocated_count == no_of_seats:
             flag = True
             break

        cur_party_quotient[item] = party_votes[item] / (seats_alloc[item] + 1)          

    if flag:
        break


print("\n\nSeat allocation is as follows:\n")    
for key, value in seats_alloc.items():
    print(key, "has got", value, "seat(s).")



