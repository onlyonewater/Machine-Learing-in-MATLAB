function word=Construct_word_vector(path,count,expr)
%������������������������
%path�Ƕ�ȡ�ļ���·����expr��������ʽ��Ҫ�и���ַ�
%count��ʾ��ȡ���ļ�������
%word�Ƿ��صĴ�����
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
    %����word�еĿ��ַ�
    m=[];
    for i=1:size(word,2)
        if all(isspace(word{i})==1)==1
            m=[m,i];
        end
    end
    word(m)=[];
end