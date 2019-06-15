function Nearest=searchTree(tree,point)
%������
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

if iscell(Leaf)==1
    Result=searchTree(Leaf,point);
    dist=sqrt((node(1,1)-point(1,1))^2+(node(1,2)-point(1,2))^2);
    %�Ƚ����������С��ȡС
    if Result{1,2}<dist
        Nearest=Result{1,2};
    else
        Nearest={node(1:2),dist};
    end
else
    %�ж��Ƿ�Ϊ��ֵ
    if ~isempty(Leaf)
        %��������ľ���
        dist1=sqrt((Leaf(1,1)-point(1,1))^2+(Leaf(1,2)-point(1,2))^2);
        %��������ľ���
        dist2=sqrt((node(1,1)-point(1,1))^2+(node(1,2)-point(1,2))^2);
        %�Ƚ����������С��ȡС
        if dist1<dist2
            Nearest={Leaf,dist1};
        else
            Nearest={node(1:2),dist2};
        end
    end
end
end
