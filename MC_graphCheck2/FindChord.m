function [ Flag ] = FindChord( Left_Graph,Vpos,WeightedV,WeightSet )
    NumOfUE = size(WeightSet,2);
    for i=1:1:NumOfUE%set vertax whose weight is higher than WeightedV to 0;
        if(i ~= Vpos && WeightSet(i) >= WeightSet(WeightedV))%WeightedV is the "u" in the paperif
            if(i ~= WeightedV)
                for j=1:1:NumOfUE
                    Left_Graph(i,j) = 0;
                    Left_Graph(j,i) = 0;
                end
            end
        end
    end
    g = graph;%using matgraph toolbox , generate a graph
    set_matrix(g,Left_Graph);%make a graph using Left_Graph
    if(isempty(find_path(g,Vpos,WeightedV)))
        Flag = 0;
    else
        Flag = 1;
    end
    free(g);
    
        
        
        
        
   



end

