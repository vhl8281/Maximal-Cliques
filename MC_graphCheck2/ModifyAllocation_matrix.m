function [ ModifiedColumn,Allocation_matrix_c] = ModifyAllocation_matrix(ReleasedUE,NeedDealingSet,TargetUE,Allocation_matrix_c,TargetCC,TotalAvailiableMatrix,whichCliquesUEIn,UEInfo,FAPInfo,BPerCarrierMain)
                                                                         
for i=1:1:size(TotalAvailiableMatrix,1)
    Allocation_matrix_c(whichCliquesUEIn{TargetUE}(i),TargetCC) = NeedDealingSet(1,TargetUE);
end


ModifiedColumn = zeros(2,size(Allocation_matrix_c,1));
ModifiedColumn(1,:) = Allocation_matrix_c(:,TargetCC)';
% for i=1:1:size(ModifiedColumn,2)
%     if any(ReleasedUE{1} == ModifiedColumn(1,i))
%         ModifiedColumn(1,i) = 0;
%     end
% end
    
for i=1:1:size(Allocation_matrix_c,1)
    ModifiedColumn(2,i) = ReCountRate(Allocation_matrix_c(:,TargetCC),i,UEInfo,FAPInfo,BPerCarrierMain);
%     ModifiedColumn(2,i) = ReCountRate(ModifiedColumn(1,:)',i,UEInfo,FAPInfo,BPerCarrierMain);
end


% if flag == 0 && tmp == 0% all cliques for that CC are idle
%     
% else if flag == 1 % only need to release 1 UE
%     for i=1:1:size(TotalAvailiableMatrix,1)
%         Allocation_matrix_c(whichCliquesUEIn{TargetUE}(i),TargetCC) = TotalAvailiableMatrix();
%     end
%     continue;
% end
% if flag > 1% need to release more than 1 UE
%     MA_MoreThanOneUE();
%     continue;
% end

end

