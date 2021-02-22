#include<bits/stdc++.h>
using namespace std;
int main()
{

    double psnr[100];
    double mse[200];
    int n=72;
    for(int i=0;i<n/3;i++)
    {
        double x,y,z;
        cin>>x>>y>>z;
        mse[i]=(x+y+z)/3;

        psnr[i] = 10 * log10( 256*256 / mse[i]);


    }
     FILE *ou;
        ou=fopen("outfile3.txt","w");
    //ou<<mse;
    for(int i=0;i<n/3;i++)
    {

        //ofstream ou;
        //ou.open("outfile.txt");
        fprintf(ou,"MSE Value : %7.9f\n",mse[i]);
        fprintf(ou,"PSNR Value : %9.7f dB\n",psnr[i]);
    }

}
