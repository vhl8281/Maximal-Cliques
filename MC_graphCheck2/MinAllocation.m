function [ resourceGeted,resourceCompromiseGeted ] = MinAllocation( TargetUE,CLInfo_Left,UEInfo,SINR_LowerBound,CliqueUE_Left )
    NumOfClique = size(CliqueUE_Left,2);%CliqueUE is a cell
    resourceGeted = 100000000000;
    resourceCompromiseGeted = 10000000000;
    resourceTemp = 1000000000000;
    resourceCompromise = 0;
    for i=1:1:NumOfClique
        if(CliqueUE_Left{i}(TargetUE) == 1)
            resourceCompromise = CLInfo_Left(2,i)*UEInfo(3,TargetUE)/(CLInfo_Left(1,i)*log10(1+SINR_LowerBound(TargetUE)))+0.5;
            if(resourceCompromise < 1)
                resourceTemp = ceil(resourceCompromise);%avoid some vetaxes belonging to all cliques which causes allocation < 1
            else
                resourceTemp = floor(resourceCompromise);
            end
            if(resourceTemp < resourceGeted)
                resourceGeted = resourceTemp;
            end
            if(resourceCompromise < resourceCompromiseGeted)
                resourceCompromiseGeted = resourceCompromise;
            end
        end
        
    end
end

