function [ Rate_PracticalF ] = CountRateAfterPowerAdjustMent( Allocation_matrix_f,UEInfo,FAPInfo,DifferentPowerCell,BPerCarrier )
NumOfUE = size(UEInfo,2);
NumOfFAP = size(FAPInfo,2);
NumOfUEPerFAP = NumOfUE/NumOfFAP;
NumOfCC = size(Allocation_matrix_f,2);
Rate_PracticalF = zeros(1,NumOfUE);
UEsPerCCCell = cell(1,NumOfCC);
N0 = -174;%Noise (dBm/Hz)
for i=1:1:size(Allocation_matrix_f,2)
    UE_Exist = cell(1,1);
    count = 1;
    for j=1:1:size(Allocation_matrix_f,1)
        if Allocation_matrix_f(j,i) ~= 0 && ~any(UE_Exist{1} == Allocation_matrix_f(j,i))
            UE_Exist{1}(count) = Allocation_matrix_f(j,i);
            count = count + 1;
        end
    end
    [UE_Exist_Matrix,PowerOfUEInUE_Exist] = CountUEI_Matrix(UE_Exist,UEInfo,FAPInfo,DifferentPowerCell);

    for j = 1:1:size(UE_Exist{1},2)% for each UE in UE_Exist , count a Rate
        I_Power = 0;
        I_FAP = floor((UE_Exist{1}(j)-1)/NumOfUEPerFAP)+1;
        IUE = UE_Exist{1}(j);
        for k=1:1:size(UE_Exist{1},2)
            if j ~= k
                I_Power = I_Power + UE_Exist_Matrix(k,j);
            end
        end
        D = sqrt((FAPInfo(1,I_FAP)-UEInfo(1,IUE))^2+(FAPInfo(2,I_FAP)-UEInfo(2,IUE))^2);
        SINR = (PowerOfUEInUE_Exist(1,j)/10^((38.46+20*log10(D))/10))/(I_Power+10^(N0/10)*BPerCarrier);
        RateTemp = (BPerCarrier/1000)*log2(1+SINR);
        Rate_PracticalF(1,UE_Exist{1}(j)) = Rate_PracticalF(1,UE_Exist{1}(j))+RateTemp;
    end
end

end

