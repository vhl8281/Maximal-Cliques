graph = [0,1,0,0,0,0,0,0,1;
         0,0,1,0,0,0,0,0,1;
         0,0,0,1,0,0,0,1,1;
         0,0,0,0,1,1,1,1,0;
         0,0,0,0,0,1,0,0,0;
         0,0,0,0,0,0,1,1,0;
         0,0,0,0,0,0,0,1,0;
         0,0,0,0,0,0,0,0,0;
         0,0,0,0,0,0,0,0,0;];
for i = 1:1:9
    for j = 1:1:9
        if graph(i,j) == 1
            graph(j,i) = 1;
        end
    end
end
%%%%%%%%%CLIQUES alg%%%%%%%%%%%%
global FinalCliqueSet;
global Q ;
global count;
FinalCliqueSet = cell(1,1);
count = 1;
Q = zeros(1,9);
tmp = ones(1,9);
% EXPAND(FinalCliqueSet,Q,tmp,tmp);
EXPAND(tmp,tmp,graph);


     