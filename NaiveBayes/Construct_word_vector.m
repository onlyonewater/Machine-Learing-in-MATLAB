function word=Construct_word_vector(path,count,expr)
%这个函数是用来构造词向量的
%path是读取文件的路径，expr是正则表达式需要切割的字符
%count表示读取的文件的数量
%word是返回的词向量
    file=dir([path,'*.txt']);
    word={};
    for i=1:length(count)
        fid=fopen([path,file(count(i)).name]);
        while(~feof(fid))
            tmp=fgets(fid);
            k=regexp(tmp,expr,'split');
            word=[word,k];
        end
        fclose(fid)
    end
    %消除word中的空字符
    m=[];
    for i=1:size(word,2)
        if all(isspace(word{i})==1)==1
            m=[m,i];
        end
    end
    word(m)=[];
end