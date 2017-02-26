function [ RateCCi ] = CountRateOfCCi( TargetUE,Allocation_matrix,TargetCC,NumOfUEPerFAP,FAPInfo,UEInfo,BPerCarrierMain )
    TargetFAP =floor((TargetUE-1)/NumOfUEPerFAP)+1;
    N0 = -174;%Noise (dBm/Hz)
    Pi = FAPInfo(3,TargetFAP);%power of target FAP (mW)
    Liw = 5;%penetration loss of the wall(dB)
    Target_distance = sqrt((FAPInfo(1,TargetFAP)-UEInfo(1,TargetUE))^2+(FAPInfo(2,TargetFAP)-UEInfo(2,TargetUE))^2);%distance between target UE and target FAP
    PLi = 38.46+20*log10(Target_distance)+Liw;%Path Loss(m)
    BPerCarrier = BPerCarrierMain;%每载波带宽为15kHz
    NumOfClique = size(Allocation_matrix,1);
    
    I_Power = 0;
    I_exist= zeros(1,size(Allocation_matrix,1));%used to avoid counting of repetive I from same FAP 
    for i=1:1:NumOfClique
        if(Allocation_matrix(i,TargetCC) ~= TargetUE && Allocation_matrix(i,TargetCC) ~= 0)
            if(~any(I_exist == Allocation_matrix(i,TargetCC)))
                I_UE = Allocation_matrix(i,TargetCC);
                I_FAP = floor((I_UE-1)/NumOfUEPerFAP)+1;
                I_Distance = sqrt((FAPInfo(1,I_FAP)-UEInfo(1,TargetUE))^2+(FAPInfo(2,I_FAP)-UEInfo(2,TargetUE))^2);
                I_Power = I_Power + FAPInfo(3,I_FAP)/10^((38.46+20*log10(I_Distance)+Liw)/10);
                I_exist(i) = Allocation_matrix(i,TargetCC);
            end
        end
    end
            
    SINR_practical = (Pi/10^(PLi/10))/(I_Power+10^(N0/10)*BPerCarrier);
    RateCCi = (BPerCarrier/1000)*log2(1+SINR_practical);%@@@@@@@@@@@@@@@@@@@改
    
    


end

