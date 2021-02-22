import cv2

white = (255,255,255)

def show(img):
    #cv2.rectangle(img,(10,10),(240,240),white,2) #main
    
    cv2.rectangle(img,(12,12),(85,85),white,2) #1
    cv2.rectangle(img,(12,90),(85,160),white,2) #2
    cv2.rectangle(img,(12,165),(85,238),white,2) #3
    
    cv2.rectangle(img,(90,12),(160,85),white,2) #4
    cv2.rectangle(img,(90,90),(160,160),white,2) #5
    cv2.rectangle(img,(90,165),(160,238),white,2) #6

    cv2.rectangle(img,(165,12),(238,85),white,2) #7
    cv2.rectangle(img,(165,90),(238,160),white,2) #8
    cv2.rectangle(img,(165,165),(238,238),white,2) #9

