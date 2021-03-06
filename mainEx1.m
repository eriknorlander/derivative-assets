S0 = 100;
K = 85;
qu = 0.4;
qd = 1-qu;
u = 1.2;
d = 0.9;
R = 0.02;
i = 3;
o = 'c';
type = 'eu';
Ex31b = BinAlgo(S0, K, qu, qd, u, d, R, i, o,type)

%% Computer Exercise 1
% 3.1
S0 = 90;
K = 100;
r = 0.05; 
T = 1;
n = 3;
o = 'c';
type = 'eu';
sigma = 0.2;
[qu,qd,u,d] = calibrate(r,sigma,T,n);
R = exp(r*T/n)-1;
price31 = BinAlgo(S0, K, qu, qd, u, d, R, n, o, type)
%%
% 3.2a
type = 'am';
o = 'p';
N = [1,3,10];
price32put = zeros(length(N),1);
i = 1;
for n = N
    price32put(i) = BinAlgo(S0, K, qu, qd, u, d, R, n, o, type);
    i = i + 1;
end
price32put

%% 3.2b comparison put and call, checking inequality

price32put = BinAlgo(S0, K, qu, qd, u, d, R, 3, 'p', 'am');
price32call = BinAlgo(S0, K, qu, qd, u, d, R, 3, 'c', 'am');
diff = price32call - price32put;
boole = 'false';

if(S0-K < diff && diff < S0)
    boole = 'true'
else
    boole
end

%% 3.3 & 3.4 Convergence of European Call & American Put

n = 400;
priceEU = zeros(1,n);
priceAM = zeros(1,n);
for i = 1:n
    priceEU(i) = BinAlgo(S0,K,qu,qd,u,d,R,i,'c','eu');
    priceAM(i) = BinAlgo(S0,K,qu,qd,u,d,R,i,'p','am');
end

figure(1); clf;
subplot(1,2,1)
plot(1:n,priceEU)
subplot(1,2,2)
plot(1:n,priceAM)
hold on
plot(1:n,11.4927*ones(1,n))

