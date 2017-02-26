function [ UE_Exist_Matrix,PowerOfUEInUE_Exist ] = CountUEI_Matrix( UE_Exist,UEInfo,FAPInfo,DifferentPowerCell )
NumOfUE = size(UEInfo,2);
NumOfFAP = size(FAPInfo,2);
NumOfUEPerFAP = NumOfUE/NumOfFAP;
UE_Exist_Matrix = zeros(size(UE_Exist{1},2));
Liw = 5;
PowerOfUEInUE_Exist = zeros(1,size(UE_Exist{1},2));%Power of each UE in UE_Exist
for i=1:1:size(UE_Exist{1},2)
    kind = 0;
    for k=1:1:3%find power of certain IUE
        if any(DifferentPowerCell{k} == UE_Exist{1}(i));
            kind = k;
            break;
        end
    end
    if kind == 1
        PowerIUE = 10;
    elseif kind == 2
        PowerIUE = 50;
    else
        PowerIUE = 100;
    end
    PowerOfUEInUE_Exist(1,i) = PowerIUE;
    for j=1:1:size(UE_Exist{1},2)
        if i ~= j
            IUE = UE_Exist{1}(j);
            I_FAP = floor((UE_Exist{1}(i)-1)/NumOfUEPerFAP)+1;
            Dis = sqrt((FAPInfo(1,I_FAP)-UEInfo(1,IUE))^2+(FAPInfo(2,I_FAP)-UEInfo(2,IUE))^2);
            UE_Exist_Matrix(i,j) = PowerIUE/10^((38.46+Liw+20*log10(Dis))/10);
        end
    end
end
         
             
            
            

end

