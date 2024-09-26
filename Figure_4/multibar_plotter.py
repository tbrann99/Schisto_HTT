#!/usr/bin/env python3

#Import modules
import sys
import csv
import statistics

#Import and parse the file
input = sys.argv[1]
count = len(open(input).readlines(  ))
lol = list(csv.reader(open(input, 'rt'), delimiter='\t'))

def answer(result_arr):
    #print(result_arr)
    if(len(result_arr)>2):
        #return("yes")
        numover=int(result_arr[3])
        maxlen=int(result_arr[1])
        if(numover>5 and maxlen>2000):
            return("Yes2")
        elif(numover>1 and maxlen>1000):
            return("Yes1")
        else:
            return("No")
    else:
        return("No")

def send(name,P3,S3):
    ##Yes 2 is 1, Yes 1 is 2, No is 3
    print(name.replace(" ", "_"),end=",")

    if(P3=="No" and S3=="No"):
        print("0,0,0,0,0")
    elif(P3=="No"):
        print("0,0,100",end=",")
    elif(P3=="Yes2"):
        print("100,0,0",end=",")
    elif(P3=="Yes1"):
        print("0,100,0",end=",")

    if(S3=="Yes2"):
        print("100,0")
    elif(S3=="Yes1"):
        print("0,100")
    elif(S3=="No" and P3!="No"):
        print("0,0")





for i in range(0,count):
    name=lol[i][3]
    P3=lol[i][4]
    S3=lol[i][5]

    S3_out=answer(S3.split(","))
    P3_out=answer(P3.split(","))

    send(name,P3_out,S3_out)
