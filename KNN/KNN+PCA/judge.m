function f=judge(n)
%KNN手写识别，判断是哪个数字
    count0=0;count1=0;count2=0;count3=0;count4=0;count5=0;
    count6=0;count7=0;count8=0;count9=0;
    for j=1:length(n)
        if n(j)>=1&&n(j)<=189
        count0=count0+1;
        elseif n(j)>=190&&n(j)<=387
        count1=count1+1;
        elseif n(j)>=388&&n(j)<=582
            count2=count2+1;
        elseif n(j)>=583&&n(j)<=781
            count3=count3+1;
        elseif n(j)>=782&&n(j)<=967
            count4=count4+1;
        elseif n(j)>=968&&n(j)<=1154
            count5=count5+1;
        elseif n(j)>=1155&&n(j)<=1349
            count6=count6+1;
        elseif n(j)>=1350&&n(j)<=1550
            count7=count7+1;
        elseif n(j)>=1551&&n(j)<=1730
            count8=count8+1;
        else
            count9=count9+1;
        end
    end
    count=[count0,count1,count2,count3,count4,count5,count6,count7,count8,count9];
    [m,b]=max(count);
    f=b-1;
end