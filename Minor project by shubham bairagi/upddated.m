clc
clear all
[baseFileName folder] = uigetfile('*.txt;');  %taking message file from user.

fullFileName = fullfile(folder, baseFileName);
fileid=fopen(fullFileName,'r');
tline = fgetl(fileid);
while ischar(tline)                          %Reading each message from the file.
    
    
    
    [filename,user_canceled] = imgetfile;    %taking iput a image for hiding the message.
    rimg=imread(filename);
    real=rimg;
    
    
    p=tline;
    me=reshape(dec2bin(p, 8).'-'0',1,[]);
    
    
    
    t=1;
    en=0;
    siz=size(me);
    
    [x y z]=size(rimg);
    for j=1:+2:x-2
        
        for i=1:+2:y-2
            
            a1=reshape(rimg(j:j+1,i:i+1,1),1,4);
            
            a1=double(a1);
            %fprintf('red bloack %i ',a1);
            flag=0;
            for i1=1:4
                
                a1(i1)=log2(a1(i1));
            end
            b1=sort(a1);
            if b1(4)>=7
                flag=1;
            else
                IQR=(b1(2)+b1(3))/2;            %finding the iqr value 
                %fprintf(' %d\n',IQR);
                if IQR<2
                    min=1;
                else
                    if IQR<4
                        min=2;
                    else
                        min=3;
                    end
                end
                
            end
            if flag==0
                rimg(j,i,1)=bitand(rimg(j,i,1) ,min);   %red plane embidding.
                rimg(j,i,1)= bitor(rimg(j,i,1),min) ;
                
            end
            
            
            
            if flag==1
                l1=bitand(rimg(j,i,2),1);
                if l1==1
                    rimg(j,i,2)=bitxor(rimg(j,i,2),1);   %green plane as a indicator
                end
                l2=bitand(rimg(j,i+1,2),1);
                
                
                if l2==1
                    rimg(j,i+1,2)=bitxor(rimg(j,i+1,2),1);
                end
            else
                
                l1=bitand(rimg(j,i,2),1);
                if l1==0
                    %fprintf('rel %i',rimg(j,i,2));
                    rimg(j,i,2)=bitor(rimg(j,i,2),1);
                    
                end
                l2= bitand(rimg(j,i+1,2),1);
                
                
                if l2==0
                    rimg(j,i+1,2)=bitor(rimg(j,i+1,2),1);
                    % fprintf('rel %i',rimg(j,i+1,2));
                end
                
                ff=0;
                if t>=siz
                    en=1;
                end
                db=rimg(j,i,3);    %embidding the msg into blue plane.
               
                
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
                
               
                rimg(j,i,3)=b11;
                b2=de2bi(rimg(j,i+1,3),8);
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
                
                
                rimg(j,i+1,3)=b11;
                
                if en==1
                    l1=bitand(rimg(j,i,2),1);
                    
                    if(l1==1)
                        rimg(j,i,2)=bitxor(rimg(j,i,2),1);
                        l2=bitand(rimg(j,i+1,2),1);
                    end
                    
                    if l2==0
                        rimg(j,i+1,2)=bitxor(rimg(j,i+1,2),1);
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
    imshow(rimg),imsave;     %saving the image into a folder.
    
 I = real;
Ihat = rimg;

% Read the dimensions of the image.
[rows columns ~] = size(I);

% Calculate mean square error of R, G, B.   
mseRImage = (double(I(:,:,1)) - double(Ihat(:,:,1))) .^ 2;
mseGImage = (double(I(:,:,2)) - double(Ihat(:,:,2))) .^ 2;
mseBImage = (double(I(:,:,3)) - double(Ihat(:,:,3))) .^ 2;

mseR = sum(sum(mseRImage)) / (rows * columns);
mseG = sum(sum(mseGImage)) / (rows * columns);
mseB = sum(sum(mseBImage)) / (rows * columns);

% Average mean square error of R, G, B.
mse = (mseR + mseG + mseB)/3;

% Calculate PSNR (Peak Signal to noise ratio).
PSNR_Value = 10 * log10( 255^2 / mse);
    fprintf('\nPSNR(RED): %9.7f', PSNR_Value);
    tline = fgetl(fileid);
end
fclose(fileid);