clc
clear all
clc
clear all
clc
clear all
[baseFileName folder] = uigetfile('*.txt;');  %taking message file from user.

fullFileName = fullfile(folder, baseFileName);
fileid=fopen(fullFileName,'r');
tline = fgetl(fileid);
while ischar(tline)                          %Reading each message from the file.
    [filename,user_canceled] = imgetfile;
    rimg=imread(filename);
    real=rimg;
    
    p=tline;
    me=reshape(dec2bin(p, 8).'-'0',1,[]);
    
    
    
    t=1;
    en=0;
    siz=size(me);
    siz
    [x y z]=size(rimg);
    for j=1:+2:x-2
        
        for i=1:+2:y-2
            
            
        a1=reshape(rimg(j:j+1,i:i+1,1),1,4);
        
        a1=double(a1);
        %fprintf('red bloack %i ',a1);
        flag=0;
        
        b1=sort(a1);
       
            IQR=(b1(2)+b1(3))/2;
            %fprintf(' %d\n',IQR);
            if IQR<80
                min=1;
            else
                if IQR<160
                    min=2;
                else
                    if IQR>160
                    min=3;
                end
            end
            
            end
            if flag==0
                rimg(j,i,1)=bitand(rimg(j,i,1) ,min);
                rimg(j,i,1)= bitor(rimg(j,i,1),min) ;
                
            end
            
            
            
            if flag==1
                l1=bitand(rimg(j,i,3),1);
                if l1==1
                    rimg(j,i,3)=bitxor(rimg(j,i,3),1);
                end
                l2=bitand(rimg(j,i+1,3),1);
                
                
                if l2==1
                    rimg(j,i+1,3)=bitxor(rimg(j,i+1,3),1);
                end
            else
                
                l1=bitand(rimg(j,i,3),1);
                if l1==0
                    %fprintf('rel %i',rimg(j,i,2));
                    rimg(j,i,3)=bitor(rimg(j,i,3),1);
                    
                end
                l2= bitand(rimg(j,i+1,3),1);
                %fprintf('%d\n',rimg(1,1089,2));
                %fprintf('rel %i',rimg(j,i+1,2));
                
                if l2==0
                    rimg(j,i+1,3)=bitor(rimg(j,i+1,3),1);
                    % fprintf('rel %i',rimg(j,i+1,2));
                end
                
                ff=0;
                if t>=siz
                    en=1;
                end
                db=rimg(j,i,2);
                %  disp(db);
                
                b1=de2bi(db,8);
                
                s=size(b1);
                
                
                for k=1:min
                    if t>siz
                        
                        b1(k)=0;
                        continue;
                    end
                    
                    b1(k)=me(t);
                    
                    t=t+1;
                    
                    
                end
                b1=num2str(b1);
                
                b11=bin2dec(fliplr(b1));
                
                %rimg(j,i,3)
                rimg(j,i,2)=b11;
                b2=de2bi(rimg(j,i+1,2),8);
                s1=size(b2);
                for k=1:min
                    if t>siz
                        
                        b2(k)=0;
                        continue;
                    end
                    
                    b2(k)=me(t);
                    
                    t=t+1;
                    
                    
                end
                b2=num2str(b2);
                b11=bin2dec(fliplr(b2));
                
                
                rimg(j,i+1,2)=b11;
                
                if en==1
                    l1=bitand(rimg(j,i,3),1);
                    
                    if(l1==1)
                        rimg(j,i,3)=bitxor(rimg(j,i,3),1);
                        l2=bitand(rimg(j,i+1,3),1);
                    end
                    
                    if l2==0
                        rimg(j,i+1,3)=bitxor(rimg(j,i+1,3),1);
                    end
                end
                
                
                
            end
            if en==1
                break;
            end
        end
        if en==1
            break;
        end
        
    end
    imshow(rimg),imsave;
    
    InputImage=real;
    ReconstructedImage=rimg;
    n=size(InputImage);
    M=n(1);
    N=n(2);
    MSE = sum(sum((InputImage-ReconstructedImage).^2))/(M*N);
    PSNR = 10*log10(256*256/MSE);
    fprintf('\nMessage : %s \nMessage length in bits :%d\n',p,siz(2));
    fprintf('\nMSE RED: %7.9f\n MSE GREEN: %7.9f \nMSE BLUE: %7.9f', MSE(1),MSE(2),MSE(3));
    fprintf('\nPSNR(RED): %9.7f dB \nPSNR(GREEN) : %9.7f dB \nPSNR (BLUE) : %9.7f dB', PSNR(1),PSNR(2),PSNR(3));
    tline = fgetl(fileid);
end
fclose(fileid);