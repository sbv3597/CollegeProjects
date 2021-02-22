clc
clear all
[filename,user_canceled] = imgetfile;
rimg=imread(filename);
figure(1)
imshow(rimg);
title('original image');
%filters
rimg=rgb2gray(rimg);
%wiener filter
nimg=medfilt2(rimg,[3,3]);
figure, imshow(nimg);
title('wiener filter');



%gaussian filter
IO=nimg;
Iblur1 = imgaussfilt(IO,2);
Iblur2 = imgaussfilt(IO,4);
Iblur3 = imgaussfilt(IO,8);
figure(20)
imshow(Iblur1)
title('Smoothed image, \sigma = 2');
figure
imshow(Iblur2)
title('Smoothed image, \sigma = 4');
figure
imshow(Iblur3)
title('Smoothed image, \sigma = 8');




 
 %power law transform
[m n] = size(Iblur2);
Id=im2double(Iblur2);
% Computing s = c * (r ^ gamma) where r and gamma are positive constants 
c = 2;
%g =[0.5 0.7 4 5 6];% Gamma Correction Array
%for r=1:length(g)
r=6;
for p = 1 : m
    for q = 1 : n
        I3(p, q) = c * Id(p, q).^ r;  
    end
end
%figure(r), imshow(I3);title('Power-law transformation');xlabel('Gamma='),xlabel(g(r));
%end




%otsu method
n=imhist(I3); % Compute the histogram
N=sum(n); % sum the values of all the histogram values
max=0; %initialize maximum to zero
%%================================================================================================
for i=1:256
    P(i)=n(i)/N; %Computing the probability of each intensity level
end
%%================================================================================================
for T=2:255      % step through all thresholds from 2 to 255
    w0=sum(P(1:T)); % Probability of class 1 (separated by threshold)
    w1=sum(P(T+1:256)); %probability of class2 (separated by threshold)
    u0=dot([0:T-1],P(1:T))/w0; % class mean u0
    u1=dot([T:255],P(T+1:256))/w1; % class mean u1
    sigma=w0*w1*((u1-u0)^2); % compute sigma i.e variance(between class)
    if sigma>max % compare sigma with maximum 
        max=sigma; % update the value of max i.e max=sigma
        threshold=T-1; % desired threshold corresponds to maximum variance of between class
    end
end
%%====================================================================================================
GW=im2bw(I3,threshold/255); % Convert to Binary Image

%figure(3),imshow(GW); % Display the Binary Image
title('Otsu segmentation');

%border clearing
J = imclearborder(GW);

figure(3), imshow(J);
title('boarder clearing 1st');

BW2 = bwareaopen(J,100);

figure(4), imshow(BW2);
title('boarder clearing');

%skelotonization
BW3 = bwmorph(BW2,'skel',Inf);
figure(4),
imshow(BW3);
title('skelotonization');

%fusion of filter




%multiple ellipse fit




%best ellipse fit

[cols,rows] = find(BW3);
X(1,:)=rows;
X(2,:)=cols;


%ellipse fitting 
[zg, ag, bg, alphag] = fitellipse(X);
figure(5);
plotellipse(zg, ag, bg, alphag, 'k');


keySet = [2.5 2.6 2.7 2.8 2.9 3.0 3.1 3.2 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 4.1 4.2 4.3 4.4 4.5 4.6 4.7 4.8 4.9 5.0 5.1 5.2 5.3 5.4 5.5 5.6 5.7 5.8 5.9 6.0 6.1 6.2 6.3];
valueSet = [13 13.6 13.8 14 14.2 14.4 14.7 15 15.2 15.4 15.7 16 16.3 16.7 17 17.3 17.7 18 18.3 18.7 19 19.3 19.7 20 20.3 20.7 21 21.3 21.6 21.8 22 22.3 22.7 23 23.3 23.7 24 24.3 24.7];
M = containers.Map(keySet,valueSet);


 %Y = sprintf('%.1f',bg/100);
 %Y
 if ag>bg
     Y=ag/100;
 else
     Y=bg/100;
 end
 Ndecimals = 1 ;  
Thor = 10.^Ndecimals ;
 Y = round(Y*Thor)/Thor;
 Y
 M(Y)
 
img = imread('x5.bmp');
title('Ellipse output');
figure,imshow(rimg);
hold on
title('Final output');
plotellipse(zg, ag, bg, alphag, 'k');

