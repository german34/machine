function sdir = getSearchDir( objfun, xc, dfc, df0, iter, flag )
%GETSEARCHDIR compute search direction
%
% input:
%    objfun  function handle for objective function
%    xc      current iterate
%    dfc     current estimate of gradient
%    flag    identifier for method to compute search direction
%
% output:
%  sdir      search direction

sdir = [];

if strcmp( flag, 'gdsc' )
    % comupte search direction for gradient descent
    n = length(xc);
    B_k = eye(n);
    sdir = -B_k\dfc;

elseif strcmp( flag, 'newton' )
    % compute newton step
    
    [f, df, d2f] = objFunRB(xc);
    tf = issymmetric(d2f);
    diag = eig(d2f);
    isposdef = all(diag > 0);
    
    if  tf ==1 && isposdef == 1
        B_k = d2f;
    else
        n = len(xc);
        B_k = eye(n);
    end
    sdir = -B_k\dfc;

elseif strcmp( flag, 'bfgs' )
%     % compute bfgs search direction
%     iter = 0;
%     x0 = zeros(size(xc));%i dont know
%     q = grad(f(xk)) i.e. = dfc
%     for i = k-1,...,k-m;
%             
%             alpha_i = rho_i * phi_Tranpose *q;
%             q = q - alpha_i - y_i; i.e.  q = q - alpha_i - fc
%     end
% %     initialize w
%     H_k_0 = (p_k-1)^T * y_k-1
%     w = H_k_0 * q ;
%     for i = k-1,...,k-m;
%         B = rho_i * y_i_Tranpose * w;
%         w = w + phi_i(alpha_i - B);
%     end
%     
%     H_k * grad(f(xk)) = w:
%     
%     i.e. H_k = w * inverse(grad(f(xk)))
%     %sdir = -B_k\dfc;
%     % ADD YOUR CODE HERE

else
    error( ['search direction ', flag, ' not defined'] );
end

end % end of function





%#######################################################
% This code is part of the Matlab-based toolbox
% MACHINE --- MAthematical and Computational metHods
% for INverse problEms
% For details see https://github.com/andreasmang/machine
%#######################################################
