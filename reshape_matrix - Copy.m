function y = reshape2(x, m, n) 
  y = zeros(m, n);

  ix = 0; 
  for i = 1:m
     for j = 1:n
         ix = ix + 1;
         y(i, j) = x(ix);
     end 
  end 
end