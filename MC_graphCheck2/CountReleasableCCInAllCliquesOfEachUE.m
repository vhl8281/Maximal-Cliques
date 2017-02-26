function [ ReleasableCCInAllCliquesOfEachUE ] = CountReleasableCCInAllCliquesOfEachUE(R_Matrix , MinRiUE , whichCliquesUEIn , CliqueCell , Ri , Allocation_matrix)
NumOfCC = size(Allocation_matrix,2);
UEsBeyondAverInCliques = cell(1,size(whichCliquesUEIn{MinRiUE},2));% It is a cell,each row doesn't represent target 
ReleasableCCInAllCliquesOfEachUE = zeros(size(whichCliquesUEIn{MinRiUE},2) , NumOfCC);% part of Allcation_matrix
AllCertainCliques = whichCliquesUEIn{MinRiUE};%a cell contains all cliques where MinRiUE belongs
for i=1:1:size(AllCertainCliques,2)
    TClique = AllCertainCliques(i);
    count = 1;
    for j=1:1:size(CliqueCell{TClique} , 2)
        if Ri(CliqueCell{TClique}(j)) > R_Matrix(5)%we don't include certain UE with Ri lower or equals to R_Matrix(5)
            UEsBeyondAverInCliques{i}(count) = CliqueCell{TClique}(j);%create a cell to store all UEs which beyond average in each clique of MinRiUE
            count = count + 1;
        end
    end
end
for i=1:1:size(AllCertainCliques,2)
    for j=1:1:NumOfCC
        if ~isempty(find(UEsBeyondAverInCliques{i} == Allocation_matrix(AllCertainCliques(i),j),1))
            ReleasableCCInAllCliquesOfEachUE(i,j) =  Allocation_matrix(AllCertainCliques(i),j);%save those UE that both belongs to cliques of MinRiUE and beyonds min Ri in Allocation_matrix
        end
    end
end

end

