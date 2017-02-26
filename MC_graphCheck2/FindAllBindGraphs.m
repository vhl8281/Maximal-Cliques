function [ Q ] = FindAllBindGraphs( Chordal_Graph )
%     UELeft = zeros(1,NumOfUE);
%     while(1)
%         CliqueNum = 1;
%         TargetUE = 0;
%         for i=1:1:NumOfUE
%             if(UELeft(i) == 0)
%                 UELeft(i) = CliqueNum;
%                 TargetUE = i;
%                 break;
%             end
%         end
%         while(1)
%             for i=1:1:NumOfUE
%                 if(UELeft(i) == CliqueNum)
%                     for j=1:1:NumOfUE
%                         if(Chordal_Graph(TargetUE,i) == 1)
%                             UELeft(i) = CliqueNum;
%                         end
%                     end
%                 end
%             end
%         end
%     end
    n = size(Chordal_Graph,1);
    m = sum(sum(Chordal_Graph))/2;
    S = 0;j = 1;C = 1;
    Q = zeros(1,n);
    for i = 1:n
        for j = (i+1):n
            if Chordal_Graph(i,j) == 1
                if Q(i) == Q(j)
                    if Q(i) == 0
                        Q(i) = C;Q(j) = C;
                        C = C + 1;
                        S = S + 1;
                    end
                else
                    if Q(i) == 0
                        Q(i) = Q(j);
                    elseif Q(j) == 0
                        Q(j) = Q(i);
                    else
                        for k = 1:n
                            if Q(k) == Q(i)
                                Q(k) = Q(j);
                            end
                        end
                        S = S - 1;
                    end
                end
            end
        end
    end
    S;
    Q;
            


end

