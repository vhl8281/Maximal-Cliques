function [ CliqueUE_res,LSet,Et ] = DetectCliques( Chordal_Graph_Reduced )
NewNumOfUE = size(Chordal_Graph_Reduced,1);
prev_card = 0;
L = NewNumOfUE+1;
LSet = zeros(1,NewNumOfUE);%store the order of traversing
s = 0;
% Clique = zeros(1,NumOfUE);%initalize Cliques
Ks = zeros(1,NewNumOfUE);%Needed only when create new clique , avoid the wrong use of K
cliqueVi = zeros(1,NewNumOfUE);%1~NewNumOfUE means vi but not real vetax , which is the decending order of traversing
Et_count = 1;
Et = cell(1,1);
for i=NewNumOfUE:-1:1
    [TargetV,new_card,K] = MaxadjV(Chordal_Graph_Reduced,L,LSet);
    if(new_card <= prev_card)
        s = s+1;
        Ks = K;
        CliqueUE{s} = Ks;
        if new_card ~= 0
            k = NewNumOfUE;% k means vk
            for j=1:1:NewNumOfUE
                if(Ks(j) > 0 && Ks(j) <= k)
                    k = Ks(j);
                end
            end
            p = cliqueVi(k);
            Et{Et_count} = [s,p];
            Et_count = Et_count + 1;
        end
    end
    cliqueVi(i) = s;
    Ks(TargetV) = i;%Ks <- Ks and vi---set it to i not 1!!!
    L = L - 1;
    LSet(TargetV) = i;%Li+1 and vi----set it to i not 1!!!
    CliqueUE{s}(TargetV) = i;%set vi to i not 1!!!!!!
    prev_card = new_card;
end
CliqueUE_res = CliqueUE;
for i=1:1:size(CliqueUE,2)
    for j=1:1:size(CliqueUE{i} , 2)
        if(CliqueUE{i}(j) > 0)
            CliqueUE_res{i}(j) = 1;
        end
    end
end
CliqueUE_res;

end

