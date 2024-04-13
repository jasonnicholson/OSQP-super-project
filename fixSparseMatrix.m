function out = fixSparseMatrix(in)


% check the matrix
[tf, s] = matlab.internal.sparse.validateSparse(in);


if ~tf
  assert(s.IsRepairable, "Matrix is not repairable.");
  out = matlab.internal.sparse.repairSparse(in);
else
  out = in;
end