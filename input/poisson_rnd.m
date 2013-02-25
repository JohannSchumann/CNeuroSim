function rnd = poisson_rnd (l, r, c)

%    [retval, l] = common_size (l, zeros (r, c));
l=zeros(r,c)+l;

  [r, c] = size (l);
  s = r * c;
  l = reshape (l, 1, s);
  rnd = zeros (1, s);

  k = find (~(l > 0) | ~(l < Inf));
  if (any (k))
    rnd(k) = NaN * ones (1, length (k));
  end

  k = find ((l > 0) & (l < Inf));
  if (any (k))
    l = l(k);
    len = length (k);
    num = zeros (1, len);
    sum = - log (1 - rand (1, len)) ./ l;
    while (1)
      ind = find (sum < 1);
      if (any (ind))
        sum(ind) = (sum(ind)...
                    - log (1 - rand (1, length (ind))) ./ l(ind));
        num(ind) = num(ind) + 1;
      else
        break;
      end
    end
    rnd(k) = num;
  end

  rnd = reshape (rnd, r, c);

%end;
