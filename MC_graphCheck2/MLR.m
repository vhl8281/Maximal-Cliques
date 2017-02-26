function [ TargetV ] = MLR(SelectionInfo_Left )
    NumOfUE = size(SelectionInfo_Left,2);
    TempMax = zeros(1,NumOfUE);
    CLmax = 0;
    Nummax = 0;
    for i=1:1:NumOfUE
        if(SelectionInfo_Left(1,i) > CLmax)
            CLmax = SelectionInfo_Left(1,i);%find max sum of demand of each clique
        end
    end
    for i=1:1:NumOfUE
        if(SelectionInfo_Left(1,i) == CLmax)
            TempMax(i) = 1;%find position of CLmax
        end
    end
    for i=1:1:NumOfUE
        if(TempMax(i) == 1)
            if(SelectionInfo_Left(2,i) > Nummax)
                Nummax = SelectionInfo_Left(2,i);
                TargetV = i;
            end
        end
    end
    


end

