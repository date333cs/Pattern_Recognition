function x = myrand_gmm(n)
x=zeros(1,n);
g=randn(1,n);
u=rand(1,n);
mu = [1.0 2.0 3.0];     % 各ガウス分布の平均値．値を変えていろいろ試す．
sigma = [0.1 0.3 0.5]; % 各分布の標準偏差．値を変えていろいろ試す．
flag=(0<=u & u<1/3); % この例は，各分布から1/3の確率でデータが出現する場合．
x(flag)= mu(1) + sigma(1)*g(flag);
flag=(1/3<=u & u<2/3);
x(flag)= mu(2) + sigma(2)*g(flag);
flag=(2/3<=u & u<=1);
x(flag)= mu(3) + sigma(3)*g(flag);
