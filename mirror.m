function out = mirror(in)
  out = triu(in,1)' + in;
end