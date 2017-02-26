function [ Allocation_matrix,whetherAllocationSucceed,NumOfCCLeft ] = AllocateSpecificCC( Allocation_matrix,TargetUE,RESULT_TargetUE,NumOfCarriers,CliqueUE )
    NumOfClique = size(CliqueUE,2);
    NumOfCliqueBelongs = 1;
    InWhichClique = cell(1,1);
    for i=1:1:NumOfClique%generate cell of cliques which TargetUE belongs to
        if(CliqueUE{i}(TargetUE) == 1)
            InWhichClique{1}(NumOfCliqueBelongs) = i;
            NumOfCliqueBelongs = NumOfCliqueBelongs + 1;
        end
    end
    counts = RESULT_TargetUE;%Num of CCs TargetUE allocated
%     RandomOrderOfAllocation = randperm(NumOfCarriers);
    RandomOrderOfAllocation = (1:1:NumOfCarriers);
    for i=1:1:NumOfCarriers
        Flag1 = 1;
        Flag2 = 0;
        for j=1:1:size(InWhichClique{1},2)%find all the cliques including TargetUE that has free CC to allocate
            if(Allocation_matrix(InWhichClique{1}(j),RandomOrderOfAllocation(i)) > 0)
                Flag1 = 0;
                Flag2 = 1;%once a CC is not satisfied , continue "for i"
                break;
            end
        end
        if(Flag2 == 1)
            continue;
        end
        if(Flag1 == 1)%allocate CC
            for k=1:1:size(InWhichClique{1},2)
                Allocation_matrix(InWhichClique{1}(k),RandomOrderOfAllocation(i)) = TargetUE;
            end
            counts = counts - 1; %after allocate RESULT_TargetUE CCs , break
        end
        if(counts == 0)
            break;
        end
    end
    NumOfCCLeft = counts;
    whetherAllocationSucceed = 1;
    if(counts ~= 0)
        whetherAllocationSucceed = 0;
    end
                 
    
    
    
    
   
                   
                       
                        
                        
            
        
        
            


end

