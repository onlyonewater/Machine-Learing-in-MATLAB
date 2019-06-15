function Nearest=searchTree(tree,point)
%搜索树，Nearest返回的是最近的数据点
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

if iscell(Leaf)==1     %如果是cell类型的，说明还可以递归
    Res=searchTree(Leaf,point);
    dis=sqrt((node(1,1)-point(1))^2+(node(1,2)-point(2))^2);
    dis0=sqrt((Res(1,1)-point(1))^2+(Res(1,2)-point(2))^2);
    if dis0>dis
        Nearest=[node(1,1),node(1,2)];
    else
        Nearest=[Res(1,1),Res(1,2)];
    end
else
    if isempty(Leaf)==0     %虽然是double类型的，但是里面还有数值
        dis1=sqrt((node(1,1)-point(1))^2+(node(1,2)-point(2))^2);    %point与父节点的距离
        dis2=sqrt((Leaf(1,1)-point(1))^2+(Leaf(1,2)-point(2))^2);    %point与子节点的距离
        if dis1>dis2
            Nearest=[Leaf(1,1),Leaf(1,2)];
        else
            Nearest=[node(1,1),node(1,2)];
        end
    end
end
end