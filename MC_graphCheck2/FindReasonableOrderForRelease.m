function [ ReasonableOrder ] = FindReasonableOrderForRelease( Ri_c , TotalAvailiableMatrix , NeedDealingSet_i , R_Matrix )
ReasonableOrder = zeros(1,size(TotalAvailiableMatrix,2));
PromotionOfRiPerCC = 0.02;%this is a rather big but rational estimated num which can be calculate to a more precious one.
AllCCLeft = (1:1:size(TotalAvailiableMatrix,2));
CCsEstimation = R_Matrix(5) - NeedDealingSet_i(3);
DifferentGroup = cell(1,3);
count1 = 1;
count2 = 1;
count3 = 1;

% kind = 0;
for j=1:1:size(TotalAvailiableMatrix,2)%classify all the CCs
    flag = 0;
    tmp = -1;
    for k=1:1:size(TotalAvailiableMatrix,1)
        if TotalAvailiableMatrix(k,j) == 0 
            tmp = -1;
            break;
        end
        if TotalAvailiableMatrix(k,j) == 0.5
            tmp = 0;
            continue;
        end
        if TotalAvailiableMatrix(k,j) > 0.5
            if tmp ~= TotalAvailiableMatrix(k,j)
                flag = flag + 1;
                tmp = TotalAvailiableMatrix(k,j);
            end
        end
    end
    if tmp < 0
        continue;
    end
    if flag == 0
        DifferentGroup{1}(count1) = j;%all idle CCs in first group 
        count1 = count1 + 1;
    end
    if flag == 1
        DifferentGroup{2}(count2) = j;%only need allocate 1 UE
        count2 = count2 + 1;
    end
    if flag > 1
        DifferentGroup{3}(count3) = j;%need allocate more than 1 UEs----maybe no use
        count3 = count3 + 1;
    end
end
if  ~isempty(DifferentGroup{1})%all idle CCs come first
    for i=1:1:size(DifferentGroup{1},2)
        if CCsEstimation <= 0
            break;
        end
        ReasonableOrder(i) = DifferentGroup{1}(i);
        AllCCLeft(DifferentGroup{1}(i)) = 0;
        CCsEstimation = CCsEstimation - PromotionOfRiPerCC;
    end
end
flag = 1;%judge if situation of 1 UE release isn't needed
if  ~isempty(DifferentGroup{2}) && CCsEstimation > 0   %only 1 UE needed release come 2nd
    flag = 0;
%     DifferentKind = cell(1,1);%different kinds of columns 
%     DifferentColumn{1} = ones(size(TotalAvailiableMatrix,1) , 1)*(-1);
    DifferentColumn = cell(1,1);
    count = 1;
    for i=1:1:size(DifferentGroup{2},2)
        exist = 0;
        for k=1:1:size(DifferentColumn,2)
            if size(DifferentColumn{1},2) == 0 
                break;
            end
            if all(DifferentColumn{k} == TotalAvailiableMatrix(:,DifferentGroup{2}(i)))
                exist = 1;
                break;
            end
        end       
        if exist == 0
%         if exist == 0 && DifferentGroup{2}(i) ~= 300%@@@@@@@@@@@@@@@@avoid 300 special case
%             DifferentKind{1}(count) = DifferentGroup{2}(i);
            DifferentColumn{count} = TotalAvailiableMatrix(:,DifferentGroup{2}(i));
            count = count + 1;
        end     
    end
%%%%%%%%%%%%%% find all CCs of different columns %%%%%%%%%%%%%
    OneUEReleasedSet = cell(1,size(DifferentColumn,2));
    Index_OneUEReleasedSet = ones(1,size(DifferentColumn,2));
    for i=1:1:size(DifferentGroup{2},2)
        for k=1:1:size(DifferentColumn,2)
            if all(DifferentColumn{k} == TotalAvailiableMatrix(:,DifferentGroup{2}(i)))
                OneUEReleasedSet{k}(Index_OneUEReleasedSet(k)) = DifferentGroup{2}(i);
                Index_OneUEReleasedSet(k) = Index_OneUEReleasedSet(k) + 1;
                break;
            end
        end
    end
%%%%%%%%%%%%%% find a reasonable order of DifferentKind %%%%%%%%%%%%%
%     count = 1;
    DifferentColumn_thing = zeros(1,size(DifferentColumn,2));
    for i=1:1:size(DifferentColumn,2)
        for j=1:1:size(TotalAvailiableMatrix,1)
            if DifferentColumn{i}(j) ~= 0.5 
%                 DifferentColumn_thing(1,i) = TotalAvailiableMatrix(j,DifferentKind{1}(i));%CC
                DifferentColumn_thing(1,i) = Ri_c(DifferentColumn{i}(j));%Ri
%                 count = count + 1;
                break;
            end
        end
    end
    [t_x,t_y] = sort(DifferentColumn_thing,'descend');
    % modify "DifferentKind" to a more reasonable order
%     DifferentKind_c = cell(1,1);
%     for i=size(DifferentKind{1},2):-1:1
%         DifferentKind_c{1}(size(DifferentKind{1},2)-i+1) = DifferentKind{1}(t_y(i));
%     end
    %make a suitable order of released CCs
    CCsForEachKind = ceil(CCsEstimation/(PromotionOfRiPerCC*size(DifferentColumn,2)));
    exit = 0;
    for i=1:1:size(DifferentColumn,2)
        RealLenForEachKind = CCsForEachKind;%% avoid certain Kind column's CCs is smaller than CCsForEachKind
        if size(OneUEReleasedSet{t_y(i)},2) < CCsForEachKind;
            RealLenForEachKind = size(OneUEReleasedSet{t_y(i)},2);
        end
        for j = 1:1:RealLenForEachKind
            if(CCsEstimation <= 0)
                exit = 1;
                break;
            end
%             if DifferentKind_c{1}(i)+j-1>300%%%%%when 300 is contained , problems appears
%                 continue;
%             end
            ReasonableOrder(size(DifferentGroup{1},2)+(i-1)*CCsForEachKind+j) = OneUEReleasedSet{t_y(i)}(j);
            AllCCLeft(OneUEReleasedSet{t_y(i)}(j)) = 0;
            CCsEstimation = CCsEstimation - PromotionOfRiPerCC; 
        end
        if exit == 1;
            break;
        end
    end
    for i=1:1:size(AllCCLeft,2)%when 1 UE released CC is not enough , CC left are used
        if ReasonableOrder(i) == 0
            tail = i;
            break;
        end
    end
    %make a reasonable order of Left CCs
    LeftCCSet = zeros(3,size(AllCCLeft,2)-tail+1);
    count = 1;
    for i=1:1:size(AllCCLeft,2)
        if AllCCLeft(i) ~= 0
            LeftCCSet(1,count) = i;
            count = count + 1;
        end
    end
    for i=1:1:size(LeftCCSet,2)%count each CC with min Ri UE
        tmpSet = cell(1,1);
        count = 1;
        minRi = 10;%large enough Ri
        for j=1:1:size(TotalAvailiableMatrix,1)
            if TotalAvailiableMatrix(j,LeftCCSet(1,i)) ~= 0.5 && ~any(tmpSet{1} == TotalAvailiableMatrix(j,LeftCCSet(1,i)))
                if TotalAvailiableMatrix(j,LeftCCSet(1,i)) ~= 0 %there may be 0 in TotalAvailiableMatrix because there are some UEs in NeedDealingSet 
                    tmpSet{1}(count) = TotalAvailiableMatrix(j,LeftCCSet(1,i));
                    count = count + 1;
                    if Ri_c(TotalAvailiableMatrix(j,LeftCCSet(1,i))) < minRi
                        minRi = Ri_c(TotalAvailiableMatrix(j,LeftCCSet(1,i)));
                    end
                else
                    minRi = 10;
                    break;
                end
            end
        end
        LeftCCSet(2,i) = minRi;
    end
    [x,y] = sort(LeftCCSet(2,:),'descend');
    for i=1:1:size(LeftCCSet,2)
        LeftCCSet(3,i) = LeftCCSet(1,y(i));
    end
    for i=1:1:size(LeftCCSet,2)
        ReasonableOrder(tail) = LeftCCSet(3,i);
        tail = tail + 1;      
    end
    %here many special circumstance are not considered!!!They are :
    %1. CCsForEachKind is over one of the DifferentKind CC
    %2. if only 1 UE release  can not reach the goal , remaining CCs are
    %   join after 
    %3. Maybe there is a UE with very low Ri . After released , that UE'Ri is
    %   below min Ri
end
if flag == 1%when 1 UE release
    tail = 0;
    for i=1:1:size(TotalAvailiableMatrix,2)
        if ReasonableOrder(i) == 0
            tail = i;
            break;
        end
    end
    for i=1:1:size(TotalAvailiableMatrix,2)
        if AllCCLeft(i) ~= 0
            ReasonableOrder(tail) = AllCCLeft(i);
            tail = tail + 1;
        end
    end
end
            

end

