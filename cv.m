function errcv=cv(X,Y,k) % X はデータ，Y は正解ラベル，k は近傍数

h=5;  % この 5 という値は何？ クロスバリデーション用の部分集合の数．
n=size(X,2); % n=5000 訓練サンプル数．
ind=floor((randperm(n)-1)*h./n)+1; %  各データが，どの部分集合に属するかを決める．
% ind の形は 1x5000．要素は 1 〜 5 の数字．

for t=1:h

    Xt=X(:,ind~=t); % ind が t でないもの．ind というのは index の略？
    Yt=Y(ind~=t);

    Xv=X(:,ind==t);
    Yv=Y(ind==t);

    Yhv=knn(Xt,Yt,Xv,k);  % Yhv に部分集合 t を除くデータ Xt を使って，部分集合 t のデータ Xv を判定した結果を保存．
    err(t)=mean(Yhv~=Yv);
end
errcv=mean(err);


% randperm(5)
% ans =
%
%   3   5   2   1   4
%
