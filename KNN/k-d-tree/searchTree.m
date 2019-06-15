function Nearest=searchTree(tree,point)
%��������Nearest���ص�����������ݵ�
node_number=2;left_number=4;right_number=6;
node=tree{1,node_number};    %�ڵ�
Leaf=tree{1,left_number};     %Ĭ���Ǵ���������ʼ����
if node(1,3)==1     %����x��Ƚ�
    if node(1,1)<point(1)
        Leaf=tree{1,right_number};
    end
else      %����y��Ƚ�
    if node(1,2)<point(2)
        Leaf=tree{1,right_number};
    end
end

if iscell(Leaf)==1     %�����cell���͵ģ�˵�������Եݹ�
    Res=searchTree(Leaf,point);
    dis=sqrt((node(1,1)-point(1))^2+(node(1,2)-point(2))^2);
    dis0=sqrt((Res(1,1)-point(1))^2+(Res(1,2)-point(2))^2);
    if dis0>dis
        Nearest=[node(1,1),node(1,2)];
    else
        Nearest=[Res(1,1),Res(1,2)];
    end
else
    if isempty(Leaf)==0     %��Ȼ��double���͵ģ��������滹����ֵ
        dis1=sqrt((node(1,1)-point(1))^2+(node(1,2)-point(2))^2);    %point�븸�ڵ�ľ���
        dis2=sqrt((Leaf(1,1)-point(1))^2+(Leaf(1,2)-point(2))^2);    %point���ӽڵ�ľ���
        if dis1>dis2
            Nearest=[Leaf(1,1),Leaf(1,2)];
        else
            Nearest=[node(1,1),node(1,2)];
        end
    end
end
end