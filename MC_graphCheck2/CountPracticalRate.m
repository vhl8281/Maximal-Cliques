function [ Rate_practical,PracticalCondition_i,PracticalCondition_SINR_i ] = CountPracticalRate( TargetUE,Allocation_matrix,CliqueUE,BPerCarrierMain,NumOfUEPerFAP,FAPInfo,UEInfo )
    NumOfClique = size(CliqueUE,2);                                                              
    NumOfCC = size(Allocation_matrix , 2);
    NumOfCarriers = size(Allocation_matrix,2);
    
%     I_SINR = 0;
    OneOfCliqueIn = 0;
%     NumberCCAllocated = zeros(1,RESULT(TargetUE));---primary code 
    
    for i=1:1:NumOfClique
        if(CliqueUE{i}(TargetUE) == 1)
            OneOfCliqueIn = i;
            break;
        end
    end
    counts = 1;
    NumberCCAllocated = cell(1,1);
    for i=1:1:NumOfCC
        if(Allocation_matrix(OneOfCliqueIn,i) == TargetUE)
%             NumberCCAllocated(counts) = i;---primary code
            NumberCCAllocated{counts} = i;%---present code
            counts = counts + 1;
        end
%         if(counts > RESULT(TargetUE))---primary code
%             break;
%         end
    end
    Rate_practical = 0;
    PracticalCondition_i = zeros(1,NumOfCarriers);
    PracticalCondition_SINR_i = zeros(1,NumOfCarriers);
%     for i=1:1:RESULT(TargetUE)---primary code
    if(isempty(NumberCCAllocated{1}))
        Rate_practical = 0;
    else
        for i=1:1:size(NumberCCAllocated,2)%----recent code
            %         RateCCi = CountRateOfCCi(TargetUE,Allocation_matrix,NumberCCAllocated(i),NumOfUEPerFAP,FAPInfo,UEInfo,BPerCarrierMain);
            RateCCi = CountRateOfCCi(TargetUE,Allocation_matrix,NumberCCAllocated{i},NumOfUEPerFAP,FAPInfo,UEInfo,BPerCarrierMain);%----recent code
            PracticalCondition_i(NumberCCAllocated{i}) = RateCCi;%----recent code
            PracticalCondition_SINR_i(NumberCCAllocated{i}) = 10^(RateCCi*1000/BPerCarrierMain)-1;%----recent code
            Rate_practical = Rate_practical + RateCCi;
        end
    end
    
    
end

