function [ UEInfo,FAPInfo ] = RandomSpreadUE_FAP( NumOfFAP,NumOfUEPerFAP )
    RegionWidth = 200;%unit (m)
    RegionLength = 200;%unit (m)
    CoverRadisOfFAP = 10;%unit (m)
    MinRadisBetFAP_UE = 3;%unit (m)
    
    NumOfUE = NumOfFAP*NumOfUEPerFAP;
    UEInfo = zeros(4,NumOfUE);
    FAPInfo = zeros(3,NumOfFAP);
    a = randi([0,RegionWidth],2,NumOfFAP);
    num = 0;
    while(1)
        flag = 1;
        for i=1:1:NumOfFAP
            for j=1:1:NumOfFAP
                if(i ~= j)
                    distance = sqrt((a(1,i)-a(1,j))^2+(a(2,i)-a(2,j))^2);
                    if(distance < CoverRadisOfFAP)
                        a(1,j) = randi([0,RegionWidth]);
                        a(2,j) = randi([0,RegionWidth]);
                        flag = 0;
                    end
                end
            end
        end
        num = num + 1 ;
        if(flag == 1)
            break;
        end
    end
    b = zeros(2,NumOfFAP*NumOfUEPerFAP);
    for i=1:1:NumOfFAP
        for j=1:1:NumOfUEPerFAP;
            angle = rand()*360;
            %Fr = (r^2-3^2)/(10^2-3^2);%Fr is distribution function of r
            %r = sqrt((10^2-3^2)*Fr+3^2);
            r = sqrt(91*rand()+9);
%             r = sqrt(21*rand()+4);
            b(1,(i-1)*NumOfUEPerFAP+j) = a(1,i)+r*cos(angle*pi/180);
            b(2,(i-1)*NumOfUEPerFAP+j) = a(2,i)+r*sin(angle*pi/180);
        end
    end
    UEInfo(1,:) = b(1,:);
    UEInfo(2,:) = b(2,:);
    FAPInfo(1,:) = a(1,:);
    FAPInfo(2,:) = a(2,:);
    %%%%%%%%%random power%%%%%%%%%%%%
%     tmp = randperm(NumOfFAP);
%     for i=1:1:NumOfFAP%set power of each FAP
%         if(mod(tmp(i),3) == 0)
%             FAPInfo(3,i) = 10;%power unit (mW)
%         elseif(mod(tmp(i),3) == 1)
%             FAPInfo(3,i) = 50;%power unit (mW)
%         else
%             FAPInfo(3,i) = 100;%power unit (mW)
%         end
%     end
    %%%%%%%%%same power%%%%%%%%%%%%
    for i=1:1:NumOfFAP%set power of each FAP
        FAPInfo(3,i) = 10;
    end
    
    %Load Of UEs are 384(11.3%),512(37.8%),700(45.9%),3400(5%)
    D384 = floor(NumOfUE*0.113);
    D512 = floor(NumOfUE*0.378);
    D700 = floor(NumOfUE*0.459);
    D3400 = NumOfUE-D384-D512-D700;
    
    D = [384*ones(1,D384),512*ones(1,D512),700*ones(1,D700),3400*ones(1,D3400)];
    UEInfo(3,:) = D(randperm(NumOfUE));
%%%%%%%%% trying same minimum 
%     UEInfo(3,:) = 384*ones(1,NumOfUE);
    
    
    
    
end

