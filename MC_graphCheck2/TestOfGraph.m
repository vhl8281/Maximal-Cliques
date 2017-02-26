% 10FAP,I_R = 20,TAO = 10,P:50,20:
% R_min RN_min R_aver RN_aver
% >1  
% >1  
% 0.62  0.76   1.13   1.06
% 0.75  0.83   1.16   1.07
% 
% 20FAP,I_R = 20,TAO = 10,P:50,20:
% R_min RN_min R_aver RN_aver
% 0.49  0.60   1.06   0.88
% 0.43  0.47   1.16   0.99
% 0.42  0.49   1.03   0.95
% 
% 40FAP,I_R = 20,TAO = 10,P:50,20:
% R_min RN_min R_aver RN_aver
% 0.31  0.38   0.80   0.74
% 0.34  0.39   0.79   0.72
% 0.20  0.21   0.70   0.76
% 
% 60FAP,I_R = 20,TAO = 10,P:50,20(100)---(RiPerCC:0.015):
% R_min RN_min R_aver RN_aver
% 0.19  0.23   0.58   0.52
% 0.13  0.17   0.53   0.60
% 0.15  0.22   0.55   0.49
% 
% 80FAP,I_R = 20,TAO = 10,P:50,20(100)---RiPerCC:0.01:
% R_min RN_min R_aver RN_aver
% 0.13  0.17   0.45   0.39
% 0.10  0.12   0.45   0.38
% 0.13  0.14   0.43   0.37
% 
% 100FAP,I_R = 20,TAO = 10,P:50,20(100)---RiPerCC:0.01:
% R_min RN_min R_aver RN_aver
% 0.08  0.09   0.38   0.32
% 0.07  0.10   0.36   0.29
% 0.04  0.05   0.35   0.29
% 
% 120FAP,I_R = 20,TAO = 10,P:50,20(100)---RiPerCC:0.01:
% R_min RN_min R_aver RN_aver
% 0.04  0.05   0.30   0.25
%%%%%%%%%%%%%%%%% Data version 2 for Power Adjuestment
% 10FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 1.00  1.05   1.2    1.6     3.8          4.9
% 0.81  0.81   1.1    1.4     3.5          4.6
% 
% 20FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 0.51  0.63   1.00   1.26    5.9          7.8
% 0.56  0.71   0.98   1.24    5.8          7.7
% 
% 40FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 0.28  0.60   0.76   0.99    8.4          11.4
% 0.25  0.54   0.74   0.97    8.2          11.2
% 
% 
% 60FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 0.21  0.36   0.55   0.75    9.1          12.8
% 0.24  0.37   0.56   0.78    9.4          13.5
% 
% 80FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 0.09  0.17   0.45   0.62    10.0         14.3
% 0.13  0.23   0.45   0.62    9.8          13.9
% 
% 100FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 0.06  0.12   0.35   0.49    9.8         13.7
% 
% 120FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 0.04  0.08   0.27   0.37    8.9         12.1
figure(1)
x = [10,20,40,60,80,100,120];
yR_min = [0.90,0.53,0.27,0.23,0.12,0.06,0.04];
yRN_min = [0.95,0.68,0.56,0.36,0.20,0.12,0.08];
yR_aver = [1.15,1.01,0.75,0.55,0.45,0.35,0.27];
yRN_aver = [1.6,1.26,0.99,0.76,0.62,0.49,0.37];
yPaper_min = [1,0.93,0.75,0.55,0.35,0.3,0.21];
plot(x,yR_min,'*-');
hold on
plot(x,yRN_min,'o-');
hold on
plot(x,yR_aver,'+-');
hold on
plot(x,yRN_aver,'^-');
hold on
plot(x,yPaper_min,'.-');
legend('调整前最低满意度(不包括分配不成功的用户)','调整后最低满意度','调整前平均满意度','调整后平均满意度','文章中最低满意度')
xlabel('FAP个数')
ylabel('满意度')
figure(2)
x = [10,20,40,60,80,100,120];
R_throughput = [3.6,5.8,8.3,9.2,10.0,9.8,8.9];
RN_throughput = [4.9,7.8,11.4,13.0,14.1,13.7,12.1];
plot(x,R_throughput,'*-');
hold on
plot(x,RN_throughput,'o-');
hold on
legend('调整前吞吐量','调整后吞吐量')
xlabel('FAP个数')
ylabel('吞吐量')

%不同I_R的结果
% 80FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 0.09  0.17   0.45   0.62    10.0         14.3
% 0.13  0.23   0.45   0.62    9.8          13.9
% model1:
% 0.10  0.18   0.47   0.67@@@I_R = 16 RN_throughput:15.6;
% 0.11  0.23   0.47   0.68@@@I_R = 14 RN_throughput:15.2;
% 0.11  0.28   0.47   0.70@@@I_R = 12 RN_throughput:15.8;
% 0.11  0.28   0.47   0.70@@@I_R = 10 RN_throughput:15.9;
% 0.11  0.26   0.47   0.70@@@I_R = 8  RN_throughput:15.9;
% 0.10  0.24   0.45   0.68@@@I_R = 6  RN_throughput:15.5;
% 
% model2:
% 0.14  0.25   0.49   0.68@@@I_R = 16 RN_throughput:15.6;
% 0.13  0.26   0.49   0.70@@@I_R = 14 RN_throughput:15.8;
% 0.12  0.29   0.50   0.72@@@I_R = 12 RN_throughput:16.2;
% 0.13  0.28   0.49   0.72@@@I_R = 10 RN_throughput:16.4;
% 0.13  0.23   0.48   0.72@@@I_R = 8  RN_throughput:16.3;
% 0.15  0.23   0.46   0.70@@@I_R = 6  RN_throughput:15.9;
% 
% 100FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 0.06  0.12   0.35   0.49    9.8         13.7
% model1:
% 0.09  0.12   0.41   0.58@@@I_R = 14 RN_throughput:16.7;
% 0.11  0.24   0.41   0.63@@@I_R = 12 RN_throughput:17.8;
% 0.11  0.25   0.42   0.64@@@I_R = 10 RN_throughput:18.3;
% 0.12  0.23   0.41   0.64@@@I_R = 8 RN_throughput:18.2;
% 0.12  0.21   0.40   0.63@@@I_R = 6 RN_throughput:17.8;
% model2:
% 0.10  0.22   0.42   0.63@@@I_R = 14 RN_throughput:17.4;
% 0.10  0.21   0.43   0.66@@@I_R = 12 RN_throughput:18.0;
% 0.12  0.24   0.42   0.65@@@I_R = 10 RN_throughput:18.4;
% 0.11  0.21   0.41   0.65@@@I_R = 8  RN_throughput:18.4;
% 0.13  0.21   0.41   0.64@@@I_R = 6  RN_throughput:18.3;
%     
% 
% 120FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 0.04  0.08   0.27   0.37    8.9         12.1
% model1:
% 0.10  0.21   0.33   0.50@@@I_R = 14 RN_throughput:17.4;
% 0.13  0.20   0.34   0.54@@@I_R = 12 RN_throughput:18.6;
% 0.10  0.20   0.34   0.55@@@I_R = 10 RN_throughput:18.9;
% 0.10  0.19   0.33   0.56@@@I_R = 8  RN_throughput:19.3;
% 0.11  0.17   0.32   0.54@@@I_R = 6  RN_throughput:18.7;
% model2:
% 0.09  0.15   0.35   0.54@@@I_R = 14 RN_throughput:17.4;
% 0.08  0.12   0.35   0.54@@@I_R = 12 RN_throughput:18.1;
% 0.07  0.22   0.35   0.55@@@I_R = 10 RN_throughput:18.6;
% 0.08  0.18   0.35   0.56@@@I_R = 8  RN_throughput:19.0;
% 0.07  0.18   0.34   0.55@@@I_R = 6  RN_throughput:18.8;
% 
% 140FAP,I_R = 20,TAO = 10,P:100,50,10:
% R_min RN_min R_aver RN_aver R_Throughput RN_Throughput
% 0.03  0.05   0.25   0.34    9.6         13.1
% model1:
% 0.05  0.10   0.30   0.46@@@I_R = 14 RN_throughput:17.8;
% 0.10  0.08   0.31   0.48@@@I_R = 12 RN_throughput:19.2;
% 0.09  0.21   0.31   0.50@@@I_R = 10 RN_throughput:20.0;
% 0.09  0.16   0.30   0.50@@@I_R = 8  RN_throughput:20.0;
% 0.09  0.13   0.29   0.48@@@I_R = 6  RN_throughput:19.5;
% model2:
% 0.04  0.09   0.28   0.48@@@I_R = 14 RN_throughput:17.4;
% 0.05  0.12   0.30   0.48@@@I_R = 12 RN_throughput:18.9;
% 0.06  0.17   0.30   0.50@@@I_R = 10 RN_throughput:19.9;
% 0.06  0.15   0.30   0.50@@@I_R = 8  RN_throughput:20.0;
% 0.06  0.15   0.29   0.48@@@I_R = 6  RN_throughput:19.5;
figure(3)
x = [6,8,10,12,14];
RN_min_40 = [38,40,41,45,49]/100;
RN_min_60 = [34,38,34,38,34]/100;
RN_min_80 = [23,24,28,29,24]/100;
RN_min_100 = [21,22,25,23,13]/100;
RN_min_120 = [17,19,21,16,15]/100;
RN_min_140 = [14,15,19,10,9]/100;
RN_aver_40 = [96,98,99,98,97]/100;
RN_aver_60 = [84,85,84,84,83]/100;
RN_aver_80 = [69,71,71,70,69]/100;
RN_aver_100 = [63,64,65,64,61]/100;
RN_aver_120 = [54,56,55,54,50]/100;
RN_aver_140 = [48,50,50,48,47]/100;
% R_throughput = [3.6,5.8,8.3,9.2,10.0,9.8,8.9];
% RN_throughput = [4.9,7.8,11.4,13.0,14.1,13.7,12.1];
plot(x,RN_min_40,'*-.');
hold on
plot(x,RN_min_60,'*--');
hold on
plot(x,RN_min_80,'*-');
hold on
plot(x,RN_min_100,'o-');
hold on
plot(x,RN_min_120,'+-');
hold on
plot(x,RN_min_140,'^-');
hold on
plot(x,RN_aver_40,'x-');
hold on
plot(x,RN_aver_60,'>-');
hold on
plot(x,RN_aver_80,'v-');
hold on
plot(x,RN_aver_100,'d-');
hold on
plot(x,RN_aver_120,'p-');
hold on
plot(x,RN_aver_140,'h-');
hold on
legend('40FAP最低满意度','60FAP最低满意度','80FAP最低满意度','100FAP最低满意度','120FAP最低满意度','140FAP最低满意度','40平均满意度','60平均满意度','80平均满意度','100平均满意度','120平均满意度','140平均满意度')
xlabel('I_R大小')
ylabel('满意度')
figure(4)
R_Paper = [7.5,5.0,3.5,2.8,2.0,1.8]/10;
RN_min = [4.9,3.9,2.8,2.4,1.9,1.8]/10;
RN_aver = [0.99,0.83,0.65,0.55,0.50,0.47];
x = [40,60,80,100,120,140];
plot(x,R_Paper,'*-');
hold on
plot(x,RN_min,'o-');
hold on
plot(x,RN_aver,'+-');
hold on
legend('文章中平均满意度','实现的满意度','实现的平均满意度')
xlabel('FAP个数')
ylabel('满意度')















