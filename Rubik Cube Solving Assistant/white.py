# white
import cv2
import numpy as np
import check

def show(img):
    mask = ~img
    mask = cv2.cvtColor(mask,cv2.COLOR_BGR2GRAY)
    i=1
    ans = []
    cv2.imshow("SA2",mask)
    while i<10:
        if(check.present(mask,i,color="w")):
            ans.append(i)
        i=i+1
    
    return ans
