function pdf = gaussian_compute(X, mu, sigma)
    %�����Ԫ��˹�ֲ�����
    dim = size(X, 2);
    meanDiff = bsxfun(@minus, X ,mu);
    pdf = 1 / sqrt( (2*pi)^dim * det(sigma) ) * exp(-1/2 * sum((meanDiff * inv(sigma) .* meanDiff),2));
end