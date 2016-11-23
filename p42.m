clear all
load digit.mat X T    % X は訓練用データ（500文字/数字），Tは評価用データ
[d, n, nc] = size(X); % d=256, n=500, nc=10
 
Z = reshape(X,[d n*nc]); % Z は 256x5000 行列．全データを並べたもの．
 
% 分散・共分散行列 V の計算
V = cov(Z');  % これで一挙に V を計算！
 
% 正定値対称行列 V の固有ベクトル・固有値の計算
[eigvec eigval] = eig(V); 
eigval = eig(V); 
 
% ここで固有ベクトルを固有値の大きい順に並べ替える必要あり．
[s, index] = sort(eigval, 'descend');
eigvec = eigvec(:,index); % eigvec は 256x256 行列
e = eigvec(:,[1,2]); % e は 256x2 行列
 
X1 = X(:,:,1)'; % 数字1の500例．X1は 500x256 行列
C1 = X1*e;  % 第1,2主成分方向の座標，500例．C1は 500x2 行列
X2 = X(:,:,2)'; % 数字2の500例
C2 = X2*e; % 第1,2主成分方向の座標，500例
 
figure(1);
clf
axis equal
plot( C1(:,1), C1(:,2), 'b+' ); % 文字種別に色をつけて2次元上にプロット
hold on
plot( C2(:,1), C2(:,2), 'r*' );
print -depsc2 pca001.eps   % pngファイルを出力したければ -dpng pca001.png
 
figure(2);
clf
imagesc(reshape(eigvec(:,1), [16 16])') % 第1主成分を表示
colormap(gray);
axis([0,17, 0,17])
axis equal
print -depsc2 pca002a.eps
 
figure(3);
clf
x = X(:,23,5); % x は数字「5」の23番目の例．256次元の縦ベクトル．
s = zeros(256,1);
for c=1:10
   a = x'*eigvec(:,c); % 第c主成分の重みを内積で求める．
   s = s + a*eigvec(:,c); % 主成分の重み付け和で画像xを再構成
end
imagesc(reshape(s, [16 16])') % s はxを再構成した画像
colormap(gray);
axis([0,17, 0,17])
axis equal
print -depsc2 pca003_m10.eps
norm(x-s)  % 画像sとxのユークリッド距離
