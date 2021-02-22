import cv2
import numpy as np
import blue
import green
import red
import yellow
import orange
import create
import text
import faces
import constants as cnst
import pattern

cap = cv2.VideoCapture(0)

while True:
    ui = cv2.imread("ui.png",1)
    
    _,frame = cap.read()
    if cnst.done == 63:
        print("DONE",cnst.ci," => ",cnst.cube)
        d = pattern.sol(cnst.cube,ui)
        cv2.imshow("Rubik Cube Solver",ui)
        if d == 0:
            print("YES")
            cnst.done = 0
            cnst.dump()
            continue
        k=cv2.waitKey(0)
        if ord('q') == k or 27 == k:
            break
    
    img = frame[150:400,200:450]
    hsv = cv2.cvtColor(img,cv2.COLOR_BGR2HSV)
    res = hsv

    xsz = int(cap.get(3))
    ysz = int(cap.get(4))
    
    #Calls
    l,B = blue.show(img,hsv)
    cnst.L["B"]=l
    l,G = green.show(img,hsv)
    cnst.L["G"]=l;
    l,R = red.show(img,hsv)
    cnst.L["R"]=l
    l,O = orange.show(img,hsv)
    cnst.L["O"]=l
    l,Y = yellow.show(img,hsv)
    cnst.L["Y"]=l
    cnst.L["W"]=[]
    #res = B | G | R | O | Y
    res[0:250,0:250,0:250]=(0,0,0)
    
    #filling White List cnst.L["W"]
    b=[0,0,0,0,0,0,0,0,0,0]
    for i in cnst.L:
        if i != "W":
            for j in cnst.L[i]:
                b[j]=1
    for i in range(1,10):
        if b[i] == 0:
            cnst.L["W"].append(i)
    
    text.put(res)
    #print(cnst.done)

    #cv2.rectangle(frame,(0,0),(xsz,ysz),(255,255,255),-1)
    
    #show
    create.show(img)
    create.show(res)
    cv2.imshow("Live Face",img)
    cv2.imshow("Calculated Face",res)
    cv2.imshow("Rubik Cube Solver",ui)
    
    k = cv2.waitKey(1)
    if k == 27 or k == ord('q'): # esacpe
        break
    elif k == ord('w'):
        cv2.waitKey(0)
    elif k == ord('s'):
        faces.save()

cap.release()
cv2.destroyAllWindows()
