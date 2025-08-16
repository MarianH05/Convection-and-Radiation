function dTdt = odeFunction(~, T, params)
    dTdt = (2*(params.L + params.R)/(params.rho*params.c*params.L*params.R))*...
        (params.h*(params.Tinf - T) + params.sigma*params.eps*(params.Tinf^4 - T^4));
end