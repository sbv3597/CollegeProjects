import cv2
import numpy as np
import constants as cnst

font = cv2.FONT_HERSHEY_SIMPLEX
white = (255,255,255)

def write(img,c,p):
    x,y=15,55
    if p == 1:
        x=x+12
        y=y+12
    elif p == 4:
        x=x+12
        y=y+90
    elif p == 7:
        x=x+12
        y=y+165
    elif p == 2:
        x=x+90
        y=y+12
    elif p == 5:
        x=x+90
        y=y+90
    elif p == 8:
        x=x+90
        y=y+165
    elif p == 3:
        x=x+165
        y=y+12
    elif p == 6:
        x=x+165
        y=y+90
    elif p == 9:
        x=x+165
        y=y+165
    cv2.putText(img,c,(x,y),font,2,white,2,cv2.LINE_AA)
    

def put(img):
    for i in cnst.L:
        #print(i, "on: ", cnst.L[i])
        for j in cnst.L[i]:
            write(img,i,j)
        
