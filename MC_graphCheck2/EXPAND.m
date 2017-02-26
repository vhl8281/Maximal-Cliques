function EXPAND(SUBG,CAND,graph)
global Q;
global FinalCliqueSet;
global count;
if isempty(find(SUBG > 0,1)) == 1
    FinalCliqueSet{count} = Q;
    count = count + 1;
%     disp('clique')
else
    u = 0;
    TAOu = -1;
    %|CAND 交 TAO(u)|
    for i=1:1:size(graph,1)
        if SUBG(i) == 1
            Tmp1 = graph(i,:).* CAND;
            if sum(Tmp1) > TAOu
                TAOu = sum(Tmp1);
                u = i;
            end
        end
    end
    %CAND-TAO(u)
    EXTu = CAND;
    for i=1:1:size(CAND,2)
        if CAND(i) == 1 && graph(u,i) == 1
            EXTu(i) = 0;
        end
    end
    while(sum(EXTu) ~= 0)
        for i=1:1:size(graph,1)
            if EXTu(i) == 1
                q = i;
                break;
            end
        end
        Q(q) = 1;% 不用声明全局变量吗？？？？？
%         disp(q);
        SUBGq = SUBG;
        for i=1:1:size(SUBG,2)
            if SUBG(i)*graph(q,i) == 0
                SUBGq(i) = 0;
            end
        end
        CANDq = CAND;
        for i=1:1:size(CAND,2)
            if CAND(i)*graph(q,i) == 0
                CANDq(i) = 0;
            end
        end
        EXPAND(SUBGq,CANDq,graph);
        CAND(q) = 0;
        Q(q) = 0;
        % 更新CAND-TAOu
%         disp('back');
        EXTu = CAND;
        for i=1:1:size(CAND,2)
            if CAND(i) == 1 && graph(u,i) == 1
                EXTu(i) = 0;
            end
        end
    end
end
end
        
        
    
        


