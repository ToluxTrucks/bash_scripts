#!/usr/bin/python

# def func_1():
#     print("Hi, I am func 1")
    
# #main body    
# if __name__=="__main__":
#     func_1()
    
    
import sys
new_list=[]
if len(new_list)==0:
    print("This list is empty, lets build it")
    while 1:
        entry=input("Enter number to build your list: ")
        if entry == "#":
            print("The final list is: %s" %(new_list))
            break
        new_list.append(entry)
        print(new_list)
else: 
    print("not empty")
    
