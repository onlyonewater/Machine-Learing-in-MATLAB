function label=test_t(n)
%   KNN手写识别test的label
    for i=1:n
        if i>=1&&i<=87
            label(i)=0;
        elseif i>=88&&i<=184
            label(i)=1;
        elseif i>=185&&i<=276
            label(i)=2;
        elseif i>=277&&i<=361
            label(i)=3;
        elseif i>=362&&i<=475
            label(i)=4;
        elseif i>=476&&i<=583
            label(i)=5;
        elseif i>=584&&i<=670
            label(i)=6;
        elseif i>=671&&i<=766
            label(i)=7;
        elseif i>=767&&i<=857
            label(i)=8;
        else
            label(i)=9;
        end
    end
end