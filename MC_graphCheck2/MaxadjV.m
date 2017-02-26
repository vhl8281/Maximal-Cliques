function [ TargetV,new_card,K ] = MaxadjV( Chordal_Graph , L , LSet )
    NumOfUE = size(Chordal_Graph,1);
    TargetV = 2;%initialize traverse vetax
    TempSum = 0;
    K = zeros(1,NumOfUE);
    for i=1:1:NumOfUE
        if(LSet(i) == 0)
            TempadjOf_i = 0;
            for j=1:1:NumOfUE%counting the num adj with LSet of vetax not in LSet 
                if(LSet(j) > 0)
                    if(Chordal_Graph(i,j) == 1)
                        TempadjOf_i = TempadjOf_i+1;
                    end
                end
            end
            
            if(TempadjOf_i > TempSum)
                TempSum = TempadjOf_i;
                TargetV = i;
            end
        end
    end
    new_card = TempSum;
    for i=1:1:NumOfUE
        if(LSet(i) > 0)
            if(Chordal_Graph(i,TargetV) == 1)
                K(i) = LSet(i);
            end
        end
    end
    
end

