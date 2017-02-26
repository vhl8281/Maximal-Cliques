function [ SINR_LowerBound ] = SINRLowerBound( CliqueUE,CliqueFAP,UEInfo,FAPInfo,TargetUE,BPerCarrierMain,I_matrix )
%     BPerCarrier = 15*1000;%-----can succeed to allocate
    BPerCarrier = BPerCarrierMain;
    NumOfUEPerFAP = size(UEInfo,2)/size(FAPInfo,2);
    TargetFAP = floor((TargetUE-1)/NumOfUEPerFAP)+1;
    N0 = -174;%Noise (dB/Hz)
    Pi = FAPInfo(3,TargetFAP);%power of target FAP (mW)
    Liw = 5;%penetration loss of the wall(dB)
    Target_distance = sqrt((FAPInfo(1,TargetFAP)-UEInfo(1,TargetUE))^2+(FAPInfo(2,TargetFAP)-UEInfo(2,TargetUE))^2);%distance between target UE and target FAP
    PLi = 38.46+20*log10(Target_distance)+Liw;%Path Loss
    
    c = size(CliqueUE,2);%r = 1,c = length of Clique
    SumIPower = 0;
    FAPTemp = zeros(1,size(FAPInfo,2));%used to avoid same FAP being counted twice
    for i=1:1:c
        if(CliqueUE{i}(TargetUE) == 0)%find cliques where targetUE is not included
            [Max_SINR , T_FAP] = MaxInterferencePowerFromFAPs( TargetUE,i,FAPInfo,UEInfo,CliqueFAP,FAPTemp, I_matrix(:,TargetUE)' );%select the FAP with the max Interference Power to TargetUE in the cliques where TargetUE isn't included
            SumIPower = SumIPower + Max_SINR;%SumIPower is SINR
            if(T_FAP ~= 0)
                FAPTemp(T_FAP) = 1;
            end
        end
    end
    SINR_LowerBound = (Pi/10^(PLi/10))/(SumIPower+10^(N0/10)*BPerCarrier);
end

