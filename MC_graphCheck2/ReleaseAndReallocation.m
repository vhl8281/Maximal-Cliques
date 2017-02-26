function [ Allocation_matrix_c,Ri_c , Rate_practical_c , PracticalCondition_c,RESULT_reinforce_c ] = ReleaseAndReallocation(UEInfo, FAPInfo , R_Matrix , Allocation_matrix , NeedDealingSet , CliqueCell , Ri , CliqueUE_Matrix,BPerCarrierMain,Rate_practical,RESULT_reinforce,PracticalCondition)
NumOfUE = size(Ri,2);
NumOfFAP = size(FAPInfo,2);
NumOfCC = size(Allocation_matrix,2);
NumOfClique = size(Allocation_matrix,1);
NumOfUEPerFAP = NumOfUE/NumOfFAP;
%%%%%%%%%%%%%% making orders of Ri And detecting cliques each UE belongs to %%%%%%%%%%%%
%  [R,whichNumInRiAndNumCliqueEachUE]= sort(RiAndNumCliqueEachUE(3,:));
%  RiOrderOfUE = zeros(1,NumOfUE);
%  for i=1:1:NumOfUE
%        RiOrderOfUE(i) = RiAndNumCliqueEachUE(1,whichNumInRiAndNumCliqueEachUE(i));%sort UE with Ri in ascending order 
%  end
 whichCliquesUEIn = cell(1,size(NeedDealingSet,2));%find which cliques each UE belongs to 
 for i=1:1:size(NeedDealingSet,2)
    count = 1;
    for j=1:1:NumOfClique
        if CliqueUE_Matrix(j,NeedDealingSet(1,i)) == 1
            whichCliquesUEIn{i}(count) = j;%@@@@@order of whichCliuqesUEIn is corresponding to NeedDealingSet order@@@@@
            count = count + 1;
        end
    end
 end
%%%%%%%%%%%%%% ??? %%%%%%%%%%%%
% ReleasableCCInAllCliquesOfEachUE = cell(1,NumOfUE);% In Ri ascending order
% CCLeftInEachClique = zeros(NumOfClique , NumOfCC);
Allocation_matrix_c = Allocation_matrix;
Ri_c = Ri;
Rate_practical_c = Rate_practical;
RESULT_reinforce_c = RESULT_reinforce;
PracticalCondition_c = PracticalCondition;

for i = 1:1:size(NeedDealingSet,2)
    CCLeftInCertainClique_RiOrderOfUE_i = DetectCCLeft(i,whichCliquesUEIn,Allocation_matrix_c);%counting CC Left
    ReleasableCCInAllCliquesOfEachUE_tmp = CountReleasableCCInAllCliquesOfEachUE(R_Matrix , i , whichCliquesUEIn , CliqueCell , Ri , Allocation_matrix_c);
    %counting releasable CC
    TotalAvailiableMatrix = CCLeftInCertainClique_RiOrderOfUE_i + ReleasableCCInAllCliquesOfEachUE_tmp;
%     OnlyOneUENeedRelease;
    ReasonableOrderForRelease = FindReasonableOrderForRelease(Ri_c , TotalAvailiableMatrix , NeedDealingSet(:,i) , R_Matrix );
    %make a reasonable order for releasing CCs , avoid some UEs reaching a
    %much low Ri
    a = zeros(1,NumOfCC);
    for j=1:1:NumOfCC
        flag = 0;
        tmp = -1;
        for k=1:1:size(TotalAvailiableMatrix,1)
            if TotalAvailiableMatrix(k,ReasonableOrderForRelease(j)) == 0
                %left represents part of CCs NeedDealingSet(i) has
                %allocated while right represents two UE aren't in same FAP
                tmp = -1;% avoid flag > 1 && tmp > 0 situation
                break;
            end
            if TotalAvailiableMatrix(k,ReasonableOrderForRelease(j)) == 0.5
                tmp = 0;
                continue;
            end
            if TotalAvailiableMatrix(k,ReasonableOrderForRelease(j)) > 0.5
                if tmp ~= TotalAvailiableMatrix(k,ReasonableOrderForRelease(j))
                    flag = flag + 1;
                    tmp = TotalAvailiableMatrix(k,ReasonableOrderForRelease(j));
                end
            end
        end
        if tmp < 0% failed to allocated this CC
            continue;
        else  % recount Rates of UEs in column TargetCC
            if flag >= 1% find released UE
                ReleasedUE = cell(1,1);
                count = 1;
                for l=1:1:size(TotalAvailiableMatrix,1)
                    if TotalAvailiableMatrix(l,ReasonableOrderForRelease(j)) ~= 0.5 && TotalAvailiableMatrix(l,ReasonableOrderForRelease(j)) ~= 0
                        if ~any(ReleasedUE{1} == TotalAvailiableMatrix(l,ReasonableOrderForRelease(j)))
                            ReleasedUE{1}(count) = TotalAvailiableMatrix(l,ReasonableOrderForRelease(j));
                            count = count+1;
                        end
                    end
                end
                for l=1:1:size(ReleasedUE{1},2)
                    Rate_practical_c(ReleasedUE{1}(l)) = Rate_practical_c(ReleasedUE{1}(l))-PracticalCondition(ReleasedUE{1}(l),ReasonableOrderForRelease(j));
                    Ri_c(ReleasedUE{1}(l)) = Rate_practical_c(ReleasedUE{1}(l))/UEInfo(3,ReleasedUE{1}(l));
                    RESULT_reinforce_c(2,ReleasedUE{1}(l)) = RESULT_reinforce_c(2,ReleasedUE{1}(l)) + 1;
                end
            end
            for m=1:1:size(Allocation_matrix_c,1)%when release certain UE , that UE in other cliques should be released too.
                if any(ReleasedUE{1} == Allocation_matrix_c(m,ReasonableOrderForRelease(j)))
                    Allocation_matrix_c(m,ReasonableOrderForRelease(j)) = 0;
                end
            end
            
            
            [ModifiedColumn,Allocation_matrix_c] = ModifyAllocation_matrix(ReleasedUE,NeedDealingSet,i,Allocation_matrix_c,ReasonableOrderForRelease(j),TotalAvailiableMatrix,whichCliquesUEIn,UEInfo,FAPInfo,BPerCarrierMain);                                                                      
            I_exist = zeros(1,size(ModifiedColumn,2));
            for l=1:1:size(ModifiedColumn,2)
                if ModifiedColumn(1,l) ~= 0 && ModifiedColumn(1,l) ~= 0.5% avoid situation where UE doesn't exist
                    if ~any(I_exist == ModifiedColumn(1,l))
                        I_exist(l) = ModifiedColumn(1,l);
                        Rate_practical_c(ModifiedColumn(1,l)) = Rate_practical_c(ModifiedColumn(1,l)) - PracticalCondition(ModifiedColumn(1,l),ReasonableOrderForRelease(j)) + ModifiedColumn(2,l);
                        Ri_c(ModifiedColumn(1,l)) = Rate_practical_c(ModifiedColumn(1,l))/UEInfo(3,ModifiedColumn(1,l));
                        PracticalCondition_c(ModifiedColumn(1,l),ReasonableOrderForRelease(j)) = ModifiedColumn(2,l);
                  
                    end
                end
            end
        end

       
        RESULT_reinforce_c(2,NeedDealingSet(1,i)) = RESULT_reinforce_c(2,NeedDealingSet(1,i)) - 1;
        if(Ri_c(NeedDealingSet(1,i)) > R_Matrix(5))
            break;
        end
        a(i) = 1;
    end
            
end
%%%%%%%%%%%%%% release remaining CCs %%%%%%%%%%%%%%%


%%%%%%%%%%%%%%detecting those CCs left of each clique %%%%%%%%%%%%
%%%%%%%%%%%%%%detecting those CCs left of each clique %%%%%%%%%%%%
%%%%%%%%%%%%%%detecting those CCs left of each clique %%%%%%%%%%%%
%%%%%%%%%%%%%%detecting those CCs left of each clique %%%%%%%%%%%%

end

