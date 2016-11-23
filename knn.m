function Uh=knn(X,Y,T,k)
% X, Y は例題とその正解ラベル．T はテストデータ．k は近傍数．
%
% 例題 (X,Y) が与えられている．
% テストデータ T について，k-NN で，カテゴリを決定せよ．
% Uh はその結果．


ntr = size(X,2);  % ntr: number of training data
nte = size(T,2);  % nte: number of test data

d=repmat(sum(X.^2,1)',[1 nte]) + repmat(sum(T.^2,1),[ntr 1])-2*X'*T;
[dum,nnind]=sort(d,1); % dum はダミー変数． nnind : nearest neigbor index

for i=1:nte % majority vote
    Ynn=Y(nnind(1:k,i));
    Ys=sort(Ynn);
    ch_flag=(Ys(1:end-1)~=Ys(2:end));
    ch=find(horzcat(1,ch_flag));
    co=horzcat(ch(2:end),k+1)-ch;
    [maxco,index]= max(co);
    Uh(1,i)=Ys(ch(index));
end
