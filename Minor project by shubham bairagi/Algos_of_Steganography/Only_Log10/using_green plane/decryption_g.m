
[filename,user_canceled] = imgetfile;
rimg=imread(filename);

me=0;
t=1;
en=0;


[x y z]=size(rimg);
for j=1:+2:x-2
    
    for i=1:+2:y-2
        
        
            l1=bitand(rimg(j,i,3),1);
            l2=bitand(rimg(j,i+1,3),1);
            
            if l1==0 && l2==1
                en=1;
                
                break;
            else
                if l1==0 && l2==0
                    continue;
                else
                    if l1==1 && l2==1
                        
        a1=reshape(rimg(j:j+1,i:i+1,1),1,4);
        a1=double(a1);
        min=bitand(a1(1),3);
        
        
            
            db=rimg(j,i,2) ;
          
            b1=de2bi(db,8);
            s=size(b1);
            for k=1:min
                me(t)=b1(k);
                t=t+1;
                
                
                
            end
            
            b2=de2bi(rimg(j,i+1,2),8);
            s1=size(b2);
            for k=1:min
                
                me(t)=b2(k);
                t=t+1;
                
            end
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



l=size(me);

x=mod(l,8);

siz=l(2)-x(2);
ms=me(1:siz);
msg = char(bin2dec(reshape(char(ms+'0'), 8,[]).'));
fprintf('Message : %s\n',msg);