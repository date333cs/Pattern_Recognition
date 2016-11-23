clear all
n = 5; mu = 0; sigma = 1;
xx= sigma*randn(n, 1)+mu;
mu_MLE = mean(xx);
sigma_MLE = std(xx, 1);
 
x = -4:0.1:4;
y = normpdf(x, mu, sigma);
y_MLE = normpdf(x, mu_MLE, sigma_MLE);
 
plot(x, y, 'r-', x, y_MLE, 'b-');
legend('true', 'estimated');
print -depsc2 gauss1d_pdf.eps  % -deps ではカラーの eps ファイルが出力されない．
