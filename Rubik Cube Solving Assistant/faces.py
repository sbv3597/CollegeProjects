import cv2
import numpy as np
import constants as cnst

def save():
    f = [[" "," "," "],[" "," "," "],[" "," "," "]]
    h=0;
    for i in cnst.L:
        for j in cnst.L[i]:
            x,y = int((j-1)/3),int((j-1)%3)
            f[x][y]=i;
            print(i," on ",j," ",x,y,f[x][y])
            h=h+1
    print(" h",h)
    print("f ",f[0],f[1],f[2])
    try:
        ind = cnst.ci[f[1][1]]
        print("ind",ind,f[1][1])
        cnst.cube[ind]=f
        if (cnst.done&(1<<ind))==0:
                cnst.done=cnst.done|(1<<ind)
    except:
        print("ERROR")
        exit

