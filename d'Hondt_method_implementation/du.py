'''

Author: Aditya Upadhye

This is a simple implementation of the d'Hondt method.

'''


no_of_seats = int(input("Enter the number of seats:\n"))
no_of_parties = int(input("Enter the number of parties:\n"))
party_votes = {}
cur_party_quotient = {}

for i in range(no_of_parties):
     party_name = input("Enter the party name: ")
     total_votes = int(input("Enter the total party votes: "))
     party_votes[party_name] = total_votes
     cur_party_quotient[party_name] = total_votes
     
     
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

        print(cur_party_quotient) #To know the party dividend values for this round.

        if seats_allocated_count == no_of_seats:
             flag = True
             break

        cur_party_quotient[item] = party_votes[item] / (seats_alloc[item] + 1)          

    if flag:
        break


print("\n\nSeat allocation is as follows:\n")    
for key, value in seats_alloc.items():
    print(key, "has got", value, "seat(s).")

     
