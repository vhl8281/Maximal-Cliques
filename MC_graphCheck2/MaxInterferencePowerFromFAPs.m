function [ Max_SINR,T_FAP ] = MaxInterferencePowerFromFAPs( TargetUE,TargetClique,FAPInfo,UEInfo,CliqueFAP,FAPTemp,I_matrix_TargetUE ) 
%     N0 = -174;%Noise (dB/Hz)
%     Pi = FAPInfo(3,TargetFAP);%power of target FAP (mW)
    NumOfUEPerFAP = size(UEInfo,2)/size(FAPInfo,2);
    Liw = 5;%penetration loss of the wall(dB)
%     Target_distance = sqrt((FAPInfo(1,TargetFAP)-UEInfo(1,TargetUE))^2+(FAPInfo(2,TargetFAP)-UEInfo(2,TargetUE))^2);%distance between target UE and target FAP
%     PLi = 38.46+20*log10((Target_distance)+Liw);%Path Loss

    cFAP=size(CliqueFAP,2);
    I_SINR = 0;% no need initializaiton---???
    Max_SINR = 0;
    T_FAP = 0;
    for i=1:1:cFAP
        if(CliqueFAP(TargetClique,i) == 1 && floor((TargetUE-1)/NumOfUEPerFAP+1) ~= i )
            if(FAPTemp(i) ~= 1 && I_matrix_TargetUE(i) ~= 1)%FAPTemp is used to avoid same FAP being counted twice or more
%                 I_matrix_TargetUE(i) used to avoid repetive counting of interference               
                distance = sqrt((FAPInfo(1,i)-UEInfo(1,TargetUE))^2+(FAPInfo(2,i)-UEInfo(2,TargetUE))^2);
                I_SINR = FAPInfo(3,i)/10^((38.46+20*log10(distance)+Liw)/10);%I_SINR is not a SINR but the Interference power
                if(I_SINR > Max_SINR)
                    Max_SINR = I_SINR;
                    T_FAP = i;
                end
            end  
        end
    end
    Max_SINR;%actually is power
    T_FAP;
end

