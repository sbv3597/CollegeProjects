import solver

cnv={}
cnv["Y"]='U'
cnv["G"]='R'
cnv["R"]='F'
cnv["W"]='D'
cnv["B"]='L'
cnv["O"]='B'

def sol(cube):
    pat=""
    for i in range(0,6):
        for j in range(0,3):
            for k in range(0,3):
                x=cube[i][j][k]
                pat=pat+str(cnv[x])
    print("PATTERN ",pat)
    ans=solver.solve(pat)
    print("solution: ",ans)

##cube=[[["Y","Y","Y"],["Y","Y","Y"],["Y","Y","Y"]],
##      [["G","G","G"],["G","G","G"],["R","R","R"]],
##      [["R","R","R"],["R","R","R"],["B","B","B"]],
##      [["W","W","W"],["W","W","W"],["W","W","W"]],
##      [["B","B","B"],["B","B","B"],["O","O","O"]],
##      [["O","O","O"],["O","O","O"],["G","G","G"]]]
##sol(cube)

