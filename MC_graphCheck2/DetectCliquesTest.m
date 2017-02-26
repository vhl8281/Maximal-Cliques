nGraph = zeros(7,7);
nGraph(1,:) = [0,0,0,0,1,0,1];
nGraph(2,:) = [0,0,1,0,0,1,0];
nGraph(3,:) = [0,1,0,0,0,1,0];
nGraph(4,:) = [0,0,0,0,0,1,1];
nGraph(5,:) = [1,0,0,0,0,1,1];
nGraph(6,:) = [0,1,1,1,1,0,1];
nGraph(7,:) = [1,0,0,1,1,1,0];
[CliqueUET,LSet,Et] = DetectCliques(nGraph);

