%%%%%%%%%%%%%%%%%%%%%%   Test Graph   %%%%%%%%%%%%%%%%%%%%%%%%%%%%
newGraph = zeros(10,10);
newGraph(1,:) = [0,0,0,1,1,0,0,0,0,0];
newGraph(2,:) = [0,0,0,0,0,1,0,1,0,0];
newGraph(3,:) = [0,0,0,0,0,1,1,0,0,0];
newGraph(4,:) = [1,0,0,0,0,0,0,1,0,0];
newGraph(5,:) = [1,0,0,0,0,0,0,0,0,1];
newGraph(6,:) = [0,1,1,0,0,0,0,0,1,0];
newGraph(7,:) = [0,0,1,0,0,0,0,0,0,1];
newGraph(8,:) = [0,1,0,1,0,0,0,0,0,1];
newGraph(9,:) = [0,0,0,0,0,1,0,0,0,1];
newGraph(10,:) = [0,0,0,0,1,0,1,1,1,0];
for i=1:1:10
    for j=1:1:10
        if newGraph(i,j) == 1
            newGraph(j,i) = 1;
        end
    end
end
NumOfUE = 10;
%%%%%%%%%%%%%%%%%%%%%%   Triangulate the Conflict Graph to a Chordal Graph   %%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = zeros(NumOfUE,NumOfUE);%Set of Chords
W = zeros(2,NumOfUE);%weight of each UE and whether certain UE is numbered
S = zeros(1,NumOfUE);%all the possible paths including certain chords
MinElimOrder = zeros(1,NumOfUE);%A minimal elimination ordering ¦Á of G and the corresponding----Maybe no use
Left_Graph = newGraph;
for n = NumOfUE:-1:1
    [V,Vpos] = max(W(1,:));%Choose an unnumbered vertex v of maximum weight w(v);
    for i=1:1:NumOfUE
        S(i) = 0;
    end
    for i=1:1:NumOfUE
        if(i ~= Vpos && W(2,i) == 0)%Though the existance of Left_Graph , W(2,i) == 0 is not used
            if(newGraph(Vpos,i) == 1)
                S(i) = 1;
            else
                if(W(1,i) > 0)
                    if(FindChord(Left_Graph,Vpos,i,W(1,:)))%find a path u, x1, x2, . . . , xk, v in G through unnumbered vertices such that w(xi) < w(u) for 1 ¡Ü i ¡Ü k
                        S(i) = 1;
                    end
                end
            end
        end
    end
    
    for i=1:1:NumOfUE
        if(S(i) > 0)
            W(1,i) = W(1,i)+1;
            if(newGraph(Vpos,i) == 0)
                F(i,Vpos) = 1;
                F(Vpos,i) = 1;
            end
        end
    end
    
    MinElimOrder(Vpos) = n;
    W(1,Vpos) = -1;
    W(2,Vpos) = -1;
    for i=1:1:NumOfUE%generate Left_Graph
        Left_Graph(i,Vpos) = 0;
        Left_Graph(Vpos,i) = 0;
    end
end
Chordal_Graph = newGraph+F;
%%%%%%%%%%%%%%%%%%%%%%   Draw the graph   %%%%%%%%%%%%%%%%%%%%%%%%%%%%
