function []=plot_tree(tree,point)
node_number=2;left_number=4;right_number=6;
%plot������
if isempty(tree{1,left_number})==1||iscell(tree{1,left_number})==0
    if tree{1,node_number}(1,3)==1      %����x��split
        plot([tree{1,node_number}(1,1),tree{1,node_number}(1,1)],[point(1),point(2)])
        hold on
    else
        plot([point(1),point(2)],[tree{1,node_number}(1,2),tree{1,node_number}(1,2)])
        hold on
    end
    return;
else
    if tree{1,node_number}(1,3)==1      %����x��split
        plot([tree{1,node_number}(1,1),tree{1,node_number}(1,1)],[point(1),point(2)])
        point(2)=tree{1,node_number}(1,1);
        hold on
    else
        plot([point(1),point(2)],[tree{1,node_number}(1,2),tree{1,node_number}(1,2)])
        point(2)=tree{1,node_number}(1,2);
        hold on
    end
    plot_tree(tree{1,left_number},point)
end
%plot������
if isempty(tree{1,right_number})==1||iscell(tree{1,right_number})==0
    if tree{1,node_number}(1,3)==1    %x���split
        plot([tree{1,node_number}(1,1),tree{1,node_number}(1,1)],[point(1),point(2)])
        hold on 
    else
        plot([point(1),point(2)],[tree{1,node_number}(1,2),tree{1,node_number}(1,2)])
        hold on
    end
    return;
else
    point=[1,10];    %�ٴγ�ʼ��point
    if tree{1,node_number}(1,3)==1    %x���split
        plot([tree{1,node_number}(1,1),tree{1,node_number}(1,1)],[point(1),point(2)])
        point(1)=tree{1,node_number}(1,1);
        hold on 
    else
        plot([point(1),point(2)],[tree{1,node_number}(1,2),tree{1,node_number}(1,2)])
        point(1)=tree{1,node_number}(1,2);
        hold on
    end
    plot_tree(tree{1,right_number},point)
end
end