function [ CCLeftInCertainClique ] = DetectCCLeft(MinRiUE,whichCliquesUEIn,Allocation_matrix_c )
NumOfCC = size(Allocation_matrix_c,2);
AllCertainCliques = whichCliquesUEIn{MinRiUE};
CCLeftInCertainClique = zeros(size(whichCliquesUEIn{MinRiUE},2) , NumOfCC);
for i=1:1:NumOfCC
    for j=1:1:size(whichCliquesUEIn{MinRiUE},2)
        if Allocation_matrix_c(AllCertainCliques(j),i) == 0
            CCLeftInCertainClique(j,i) = 0.5;
        end
    end
end% if CCLeftInEachClique(j,i) = 0.5 , that CC for certain UE is idle

end

