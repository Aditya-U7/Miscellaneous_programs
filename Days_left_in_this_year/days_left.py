'''

Author: Aditya Upadhye

A program for visualising the no of days left in the current year—along with days already spent.

'''


from datetime import date


def check_leap_year(year):
    
    year = int(year)   
    if year % 4 == 0:
        if year % 100 == 0:
            if year % 400 == 0:
                return True
            else:
                return False
        return True        
    else:
        return False


def set_first_day_date(first_day_date, cur_date):
    
    for each in ['year', 'month', 'day']:
        
        if each == 'year':
            first_day_date[each] = cur_date[each]
        else:
            first_day_date[each] = 1


def set_total_days(year):
    
    year = int(year)
    total_days = 365
    
    if check_leap_year(year):
        return (total_days + 1), True
    else:
        return total_days, False
    
        
def set_current_date(today, cur_date):
    
    time_unit = ['year', 'month', 'day']
    
    for i in range (len(today)):
        current_date[time_unit[i]] = int(today[i])


def calculate_days_spent(cur_date, days_of_the_month):
    
    days_of_previous_months = 0
    
    for days in days_of_the_month[0:(cur_date['month'] - 1)]:
        days_of_previous_months += days
    
    days_spent = days_of_previous_months + cur_date['day'] - 1
    
    return days_spent
    

def calculate_days_left_this_year(tdays, days_sp):
    return tdays - days_sp


def visualise_this_year(td, ds, dl):
    
    checkbox = '\u25a0'
    tmp = 1
    
    print("\n")
    
    while (ds > 0):
             
        print(checkbox, end=' ')
            
        if tmp % 30 == 0:
            print("\n")
            
        ds -= 1
        tmp += 1
        if ds == 0:
            checkbox = '\u2610'
            
          
    while (dl > 0):
    
        print(checkbox, end=' ')
        if tmp % 30 == 0:
            print('\n')
            
        dl -= 1 
        tmp += 1     
    
    print("\n")   


days_of_the_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
leap_year = False
first_day_date = {}
current_date = {}
today = str(date.today()).split('-')  #Setting today's date in the format [year, month, day]. You can also manually set today variable with 'today = input().split('-')'
total_days, leap_year = set_total_days(today[0])

if leap_year:
    days_of_the_month[1] += 1

set_current_date(today, current_date)
print("\n\nToday's date: ", today[0], "-" ,today[1], "-", today[2])
set_first_day_date(first_day_date, current_date)
days_spent = calculate_days_spent(current_date, days_of_the_month)
days_left = calculate_days_left_this_year(total_days, days_spent)
print("\n\nDays left in this year including the present day are: ", days_left, " out of ", total_days)
visualise_this_year(total_days, days_spent, days_left)
