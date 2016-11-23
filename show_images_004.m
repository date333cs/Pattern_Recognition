clear all
load digit.mat X T
[d, n, nc] = size(X); % d=256, n=500, nc=10
 
figure(1);
clf
for i=1:n
   x = X(:,i,4);
   subplot(20,25,i), hold on
   imagesc( flipdim( reshape(x, [16 16])', 1))
   axis([0,17, 0,17])
   axis equal
   axis off
   colormap(gray);
end
print -dpng images004.png  % 少し時間がかかる．あせらず待つ！
