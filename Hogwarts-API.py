
import requests #Importing request which we need to be able to use the API, when it has a red squiggle it needs adding
import random #Importing random so I can shuffle the students list so we get random pairing not in order

#Getting the data from the URL (endpoint) so I can use it in my code, I will be using the list of Hogwarts students for the above scenario.
endpoint = 'https://hp-api.onrender.com/api/characters/students'
response = requests.get(endpoint)
data = response.json() #information as json
#print(data) - left incase the marker wants to print it or if needing to check the data

#Function to check the input
def CheckInput(TeachingHouse): #Here I have created a function called Check Input where it checks the user input matches the data and if it does not match it will not run the code
    if TeachingHouse == "Gryffindor" or TeachingHouse == "Slytherin" or TeachingHouse == "Hufflepuff" or TeachingHouse == "Ravenclaw": #These are the four formats which are the same as the data file
        print('Thankyou! Generating list.')
    else:
        print("Please enter correct Howgarts house, please use capital for first letter of the House") #If the user does not input a correct name it will print this and will not run
        return #Exits the code

#Asking for the input and checking it is suitable
TeachingHouse = input("What Hogwarts house are you teaching today?") #Input from the teacher which house they will be teaching today
CheckInput(TeachingHouse) #Calling my function to check it is the correct input

#Filtering the students to the input we are given
Students = [student["name"] for student in data if student["house"] == TeachingHouse and student["alive"] == True and student["hogwartsStudent"] == True] #List Comprehension to filter students and add them to a list
random.shuffle(Students) #Creating a random list so the pairs are not in order using the random shuffle, if you run the code again you will never get the same pairs

#Creating the pairs
PairsHolder = [] #Here I have created a holder to store the pairs in
for i in range(0,len(Students),2): #Incrementing in two in order to pair them, starting at 0 stopping at the number of students in the list, showing slicing
    if i + 1 < len(Students): #When the number is less than the number of students and must be even so we can create pairs
        PairsHolder.append((Students[i], Students[i + 1])) #Adds the pairs in a bracket to the holder
    else: #If there is an odd number of the students the final student will be paired with 'No Partner'
        PairsHolder.append((Students[i], "No Partner"))

#Writing in the file name vs name one per line
file = open("PairsFile.txt", "w") #Opening the txt file and allowing the code to overwrite it
count = 0 #Counter
while count < len(PairsHolder): #While the counter is less than the number of pairs
    CurrentPair = PairsHolder[count]
    file.write("\n{} vs {}".format(CurrentPair[0], CurrentPair[1])) #It will write the names in this format so it says name vs name into the file called PairsFile.txt
    count += 1 #Add one to the counter otherwise it will be infinite, we only want it to run until the pairs have finished
file.close() #Closing the file once all the pairs have been written in
