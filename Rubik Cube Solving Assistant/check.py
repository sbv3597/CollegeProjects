import numpy as np
import cv2

def present(a,n,x=1,color=""):
    ker = np.ones((20,20),np.float32)/400
    if n==1:
        a = a[12:85,12:85]
    elif n==2:
        a = a[12:85,90:160]
    elif n==3:
        a = a[12:85,165:238]
    elif n==4:
        a = a[90:160,12:85]
    elif n==5:
        a = a[90:160,90:160]
    elif n==6:
        a = a[90:160,165:238]
    elif n==7:
        a = a[165:238,12:85]
    elif n==8:
        a = a[165:238,90:160]
    elif n==9:
        a = a[165:238,165:238]

    a = cv2.filter2D(a,-1,ker)
        
##    if color == "w" or color == "b" and n==5:
##        ker = np.ones((80,80),np.float32)/2500
##        a = cv2.filter2D(a,-1,ker)
##    else:
##        a=cv2.blur(a,(5,5))
    
    if a[35,35] >= 200:
        return 1
    
##    if a[35,35] >= 200:
##        print("Present in ",n)
##    else:
##        print("Not Present in ",n)
