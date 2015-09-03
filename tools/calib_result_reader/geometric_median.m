function para_new = geometric_median(para, vec)
[n,m]=size(vec);
mean_t_v=ones(n,1)*para;
sub=vec-mean_t_v;
total=zeros(1,m);
weight=0;
for i=1:n
    total = total + vec(i,:)/norm(sub(i,:));
    weight = weight + 1/norm(sub(i,:));
end
para_new=total/weight;