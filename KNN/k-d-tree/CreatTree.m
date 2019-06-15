function tree=CreatTree(data)
%构建k-d树，其中data是我们的数据
dimension=1;    %表示按照x轴进行切分
if std(data(:,1))<=std(data(:,2))
    dimension=2;        %表示按照y轴进行切分
end
k=sort(data(:,dimension));
index=ceil(length(k)/2);    %确定分类的点index
split=k(index);    %split的点
node=[];
right_data=[];
left_data=[];
for i=1:size(data,1)
    if data(i,dimension)<split
        left_data=cat(1,left_data,data(i,:));
    elseif data(i,dimension)>split
        right_data=cat(1,right_data,data(i,:));
    else
        node=data(i,:);
    end
end
%遍历左结点
if isempty(left_data)
    left_node=[];
elseif size(left_data,1)==1
    left_node=left_data;
else
    left_node=CreatTree(left_data);
end
%遍历右结点
if isempty(right_data)
    right_node=[];
elseif size(right_data,1)==1
    right_node=right_data;
else
    right_node=CreatTree(right_data);
end
node=cat(2,node,dimension);
tree={'node',node,'left_node',left_node,'right_node',right_node};
end