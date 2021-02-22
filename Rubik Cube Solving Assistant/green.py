# green
import cv2
import numpy as np
import check

def show(img,hsv):
    L = np.array([40,50,50])
    U = np.array([100,255,155])
    
    mask = cv2.inRange(hsv,L,U)
    mask = cv2.medianBlur(mask,5,5)
    res = cv2.bitwise_and(img,img,mask=mask)
    
    i=1
    ans = []
    while i<10:
        if(check.present(mask,i)):
            ans.append(i)
        i=i+1
    
    return ans,res
