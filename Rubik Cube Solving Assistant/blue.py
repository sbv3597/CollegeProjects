# blue
import cv2
import numpy as np
import check

def show(img,hsv):
    L=np.array([105,50,0])
    U=np.array([152,255,225])

    ker = np.ones((10,10),np.uint8)
    
    mask = cv2.inRange(hsv,L,U)
    mask = cv2.medianBlur(mask,7,5)
    mask = cv2.morphologyEx(mask,cv2.MORPH_OPEN,ker)
    res = cv2.bitwise_and(img,img,mask=mask)
    res = cv2.medianBlur(res,7,5)
    
    i=1
    ans = []
    while i<10:
        if(check.present(mask,i)):
            ans.append(i)
        i=i+1
    
    return ans,res
