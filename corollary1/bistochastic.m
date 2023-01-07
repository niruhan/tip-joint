function P = bistochastic(N)
%Randomly generates an NxN bistochastic matrix, P
    for ii=1:2
        x=rand(N,1);
        x=x/sum(x);
        P=full(interpMatrix(x,1,length(x),1,'circ'));
        A{ii}=P(randperm(N),randperm(N));
    end
    w=rand;
    P=w*A{1}+A{2}*(1-w);