function out = gs(p,q,var)
%     d = size(p);
    out = 1/((2*pi)*var^2)*exp(-(p-q)*(p-q)'/(2*var^2));
    return