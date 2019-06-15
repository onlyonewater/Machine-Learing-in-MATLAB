function Nearest=searchTree(tree,point)
%搜索树
node_number=2;left_number=4;right_number=6;
node=tree{1,node_number};    %节点
Leaf=tree{1,left_number};     %默认是从左子树开始搜索
if node(1,3)==1     %按照x轴比较
    if node(1,1)<point(1)
        Leaf=tree{1,right_number};
    end
else      %按照y轴比较
    if node(1,2)<point(2)
        Leaf=tree{1,right_number};
    end
end

if iscell(Leaf)==1
    Result=searchTree(Leaf,point);
    dist=sqrt((node(1,1)-point(1,1))^2+(node(1,2)-point(1,2))^2);
    %比较两个距离大小，取小
    if Result{1,2}<dist
        Nearest=Result{1,2};
    else
        Nearest={node(1:2),dist};
    end
else
    %判定是否为空值
    if ~isempty(Leaf)
        %计算两点的距离
        dist1=sqrt((Leaf(1,1)-point(1,1))^2+(Leaf(1,2)-point(1,2))^2);
        %计算与结点的距离
        dist2=sqrt((node(1,1)-point(1,1))^2+(node(1,2)-point(1,2))^2);
        %比较两个距离大小，取小
        if dist1<dist2
            Nearest={Leaf,dist1};
        else
            Nearest={node(1:2),dist2};
        end
    end
end
end
