import solver
import cv2

cnv={}
cnv["Y"]='U'
cnv["G"]='R'
cnv["R"]='F'
cnv["W"]='D'
cnv["B"]='L'
cnv["O"]='B'

font = cv2.FONT_HERSHEY_SIMPLEX
color = (51,51,51)

def show(ans,ui):
    x,y = 265,125
    j=0
    for i in ans:
        j=j+1
        if i == "Error:":
            cv2.putText(ui,"Error",(x,y),font,0.95,color,2,cv2.LINE_4)
            return 0
        cv2.putText(ui,i,(x,y),font,0.95,color,2,cv2.LINE_4)
        if j%9==0:
            x=265
            y=y+35
        else:
            x=x+45
    return 1
            
def sol(cube,ui):
    pat=""
    for i in range(0,6):
        for j in range(0,3):
            for k in range(0,3):
                X=cube[i][j][k]
                pat=pat+str(cnv[X])
    print("PATTERN ",pat)
    ans=solver.solve(pat)
    print("solution: ",ans)
    lis = ans.split()
    d = show(lis,ui)
    print("SD",d)
    return d

##cube=[[["Y","Y","Y"],["Y","Y","Y"],["Y","Y","Y"]],
##      [["G","G","G"],["G","G","G"],["R","R","R"]],
##      [["R","R","R"],["R","R","R"],["B","B","B"]],
##      [["W","W","W"],["W","W","W"],["W","W","W"]],
##      [["B","B","B"],["B","B","B"],["O","O","O"]],
##      [["O","O","O"],["O","O","O"],["G","G","G"]]]
##sol(cube)
##
