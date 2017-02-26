function [ SINR,InterferenceFAP] = ReceivedSINR( TargetUE,FAPInfo,UEInfo,SINR_Threshold,BPerCarrierMain,I_matrix_pre)
    NumOfFAP = size(FAPInfo,2);
    NumOfUE = size(UEInfo,2);
    NumOfUEPerFAP = NumOfUE/NumOfFAP;
    TargetFAP =floor((TargetUE-1)/NumOfUEPerFAP)+1;
    N0 = -174;%Noise (dBm/Hz)
    Pi = FAPInfo(3,TargetFAP);%power of target FAP (mW)
    Liw = 5;%penetration loss of the wall(dB)
    Target_distance = sqrt((FAPInfo(1,TargetFAP)-UEInfo(1,TargetUE))^2+(FAPInfo(2,TargetFAP)-UEInfo(2,TargetUE))^2);%distance between target UE and target FAP
    PLi = 38.46+20*log10(Target_distance)+Liw;%Path Loss(m)
    BPerCarrier = BPerCarrierMain;%Ã¿ÔØ²¨´ø¿íÎª15kHz
    
   
    InterferenceFAP = zeros(1,NumOfFAP);%
    
    
    %     if(Flag == 1)%reduce case
    %         FAP_left = zeros(1,NumOfFAP);
    %         for i=1:1:NumOfFAP
    %             FAP_left(i) = FAPInfo(3,i);
    %         end
    FAP_Left = I_matrix_pre(:,TargetUE)'.*FAPInfo(3,:);
    Interference_Left = zeros(1,NumOfFAP);
%     FAP_left(TargetFAP) = 1;%Make sure all the other UEs of TargetFAP which includes TargetUE are connected with TargetUE
    while(1)
        I_SINR = 0;
        for i=1:1:NumOfFAP%(considering saving the former I_SINR to save time@@@algorithm)
            if(FAP_Left(i) ~= 0 && i ~= TargetFAP)
                distance = sqrt((FAPInfo(1,i)-UEInfo(1,TargetUE))^2+(FAPInfo(2,i)-UEInfo(2,TargetUE))^2);
                I_SINR = I_SINR + FAP_Left(i)/10^((38.46+20*log10(distance)+Liw)/10);%I_SINR is not a SINR but power (mW)
                Interference_Left(i) = FAP_Left(i)/10^((38.46+20*log10(distance)+Liw)/10);
            end
        end
        SINR = (Pi/10^(PLi/10))/(I_SINR+10^(N0/10)*BPerCarrier);%initial interference from different FAPs , aim to compare with the SINR threshold
        if(SINR >= SINR_Threshold)
            break;
        end
        [MaxInterference,pos] = max(Interference_Left);%when there are more than 1 max items , pos'll be the first one
        FAP_Left(pos) = 0;%set the max FAP to 0
        Interference_Left(pos) = 0;%---------------------------FAP_Left can be omit@@@@@
        InterferenceFAP(pos) = 1;%InterferenceFAP == 1 means there is strong interference between certain FAP and that UE
    end
    
end

