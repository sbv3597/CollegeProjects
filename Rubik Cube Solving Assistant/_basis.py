import cv2
import numpy as np

cap=cv2.VideoCapture(0)
ker = np.ones((10,10),np.uint8)

while True:
    _,f=cap.read();
    f=cv2.flip(f,1)
    img = f[100:360,100:360]
    white = (255,255,255)

    hsv = cv2.cvtColor(img,cv2.COLOR_BGR2HSV)
    
    cv2.rectangle(img,(10,10),(240,240),white,2) #main
    
    cv2.rectangle(img,(11,11),(90,90),white,2) #1
    cv2.rectangle(img,(85,85),(165,165),white,2) #5
    cv2.rectangle(img,(160,160),(238,238),white,2) #9
    
    cv2.rectangle(img,(11,85),(90,165),white,2) #2
    cv2.rectangle(img,(11,160),(90,238),white,2) #3
    
    cv2.rectangle(img,(85,11),(165,90),white,2) #4
    cv2.rectangle(img,(85,160),(165,238),white,2) #6

    cv2.rectangle(img,(160,11),(238,90),white,2) #7
    cv2.rectangle(img,(160,85),(238,165),white,2) #8
    
    

    #YELLOW MASKING READY Perfect

    lyellow = np.array([15,50,50])
    uyellow = np.array([45,255,255])

    masky = cv2.inRange(hsv,lyellow,uyellow)
    masky = cv2.medianBlur(masky,7,5)
    masky = cv2.morphologyEx(masky,cv2.MORPH_OPEN,ker)
    resy = cv2.bitwise_and(img,img,mask=masky)
    #cv2.imshow("MASk yel", masky)
    #cv2.imshow("yel2",resy)



    # BLUE MASKING Ready Perfect

    lblue=np.array([105,50,0])
    ublue=np.array([152,255,225])

    maskb = cv2.inRange(hsv,lblue,ublue)
    maskb = cv2.medianBlur(maskb,7,5)
    maskb = cv2.morphologyEx(maskb,cv2.MORPH_OPEN,ker)
    resb = cv2.bitwise_and(img,img,mask=maskb)
    resb = cv2.medianBlur(resb,7,5)
    #cv2.imshow("Mask Blue",maskb)
    #cv2.imshow("Res Blue",resb)


    # RED MASKING Ready Perfect

    lred=np.array([150,150,110])
    ured=np.array([180,255,255])
    
    maskr = cv2.inRange(hsv,lred,ured)
    maskr = cv2.medianBlur(maskr,7,5)
    resr = cv2.bitwise_and(img,img,mask=maskr)
    resr = cv2.medianBlur(resr,7,5)
    #cv2.imshow("Mask Red",maskr)
    #cv2.imshow("Res Red",resr)


    # Orange MASKING Ready Perfect

    loran = np.array([0,100,100])
    uoran = np.array([15,255,255])

    masko = cv2.inRange(hsv,loran,uoran)
    masko = cv2.medianBlur(masko,7,5)
    reso = cv2.bitwise_and(img,img,mask=masko)
    #cv2.imshow("mask orange",masko)
    #cv2.imshow("res orange",reso)


    # White Masking 

    lwhite = np.array([0,0,200])
    uwhite = np.array([180,60,255])
    maskw = cv2.inRange(hsv,lwhite,uwhite)
    resw = cv2.bitwise_and(img,img,mask=maskw)
    #cv2.imshow("mask white",maskw)
    #cv2.imshow("RES", resw)


    # Green Masking Ready Perfect

    lgreen = np.array([40,80,50])
    ugreen = np.array([100,255,155])
    
    maskg = cv2.inRange(hsv,lgreen,ugreen)
    maskg = cv2.medianBlur(maskg,5,5)
    resg = cv2.bitwise_and(img,img,mask=maskg)
    #cv2.imshow("mask green",maskg)
    #cv2.imshow("res green",resg)
    
    mask = maskr | masky | maskb | masko | maskg #| maskw
    colors = resr | resy | resb | reso | resg #| resw
    #cv2.imshow("MASK",mask)
    cv2.imshow("All Colors - {White}",colors);
    
    cv2.imshow("LIVE",img)
    f[100:360,100:360] = img
    cv2.imshow("F",f)
    
    k=cv2.waitKey(1)
    if k == 27: # escape
        break
cap.release()
cv2.destroyAllWindows()

