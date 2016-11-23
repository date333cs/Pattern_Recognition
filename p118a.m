clear all
n = 5000; % 標本数（サンプル数）．
x = myrand_gmm(n); % 乱数の生成．実験に使うデータを生成する関数名に書き換える．
m = 3; % 混合数．この値を変えて実験する．

% 初期値の設定．w, mu, sigma2 は m 次元縦ベクトル．
L = -inf; 
w = ones(m, 1)/m; % m個の正規分布の重みの初期値
mu = linspace( min(x), max(x), m)'; % 平均値の初期値
sigma2 = ones(m, 1)/10; % 分散の初期値
  
while 1
  tmp1 = ( repmat(x, [m 1]) - repmat(mu, [1 n])).^2;
  tmp2 = 2*repmat( sigma2, [1 n] );
  tmp3 = repmat(w, [1 n]).*exp(-tmp1./tmp2)./sqrt(pi*tmp2);
  eta = tmp3./repmat(sum(tmp3, 1), [m 1]); % ここまでがηの計算
  tmp4 = sum(eta, 2);
  w = tmp4/n; 
  mu = (eta*x')./tmp4;
  sigma2 = sum(tmp1.*eta, 2)./tmp4;
  Lnew = sum(log(sum(tmp3,1))); % 更新後の対数尤度 *** 教科書誤植あり
  mu, sigma2, w
  if Lnew -L < 0.0001
    break
  end
  L = Lnew;
end

xx = 0:0.01:5;
% octave v2 → v3 正規分布関連の関数の第3 引数は，分散ではなく，標準偏差を指定
y1 = normpdf(xx, mu(1), sqrt(sigma2(1)) );
y2 = normpdf(xx, mu(2), sqrt(sigma2(2)) );
y3 = normpdf(xx, mu(3), sqrt(sigma2(3)) );
y = y1/3 + y2/3 + y3/3;

figure(1); clf;
hist(x, 0:0.1:5,10);
print -dpng hist801.png % pngファイルを出力したければ -dpng hist801.png

% もとの分布が混合ガウス分布の場合，もとのパラメータを指定し比較するのがよい．
figure(2); clf;
plot(xx, y1, 'r-', xx, y2, 'r-', xx, y3, 'r-', xx, y, 'b-');
print -dpng gmm801.png
