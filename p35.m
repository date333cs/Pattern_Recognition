clear all
mu=[0; 0];
Sigma=[2 1; 1 2]; % 分散・共分散行列
x=[-3:0.1:3]; % x軸，y軸共に，-3 から 3 まで 0.1 刻み．
y=[-3:0.1:3];
for xx=1:length(x) % length(x) は x の要素数．ここでは 61 のはず．
  for yy=1:length(y)
    z(xx,yy)=g2_pdf(x(xx),y(yy), mu, Sigma); % x(1)=-3, x(61)=3
  end
end
 
figure(1);
clf
surf(x,y,z);
view(45,60)
print -depsc2 gauss2d_pdf_surf.eps  % -deps ではカラーの eps ファイルが出力されない．
 
figure(2);
clf
contour(x,y,z);
print -depsc2 gauss2d_pdf_contour.eps
