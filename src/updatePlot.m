function updatePlot(ax, ax3D, T0, h, eps, ts)

    %% Physical parameters
    params.rho   = 2700;
    params.c     = 900;
    params.eps   = eps;
    params.h     = h;
    params.sigma = 5.67e-8;
    params.L     = 0.5;
    params.R     = 0.1;
    params.T0    = T0;
    params.Tinf  = 300;
    params.Tfinal= 305;

    %% Solve ODE
    tspan = [0, max(1000, 100000*(abs(T0 - params.Tinf) >= 5))];
    options = odeset('Events', @(t,T) Terminal(t, T, params), 'RelTol', 1e-6, 'AbsTol', 1e-8);
    [t, T_real] = ode45(@(t,T) odeFunction(t, T, params), tspan, T0, options);
    T_real(end) = params.Tfinal;

    %% Analytical convection solution
    k_conv   = 2*h*(params.L + params.R) / (params.rho * params.c * params.L * params.R);
    T_conv   = params.Tinf + (T0 - params.Tinf) * exp(-k_conv * t);

    %% Interpolation for animation
    fps      = 30;                 % frames per second
    nFrames  = round(ts * fps);
    t_interp = linspace(t(1), t(end), nFrames);
    T_interp = interp1(t, T_real, t_interp, 'spline');
    Tconv_interp = interp1(t, T_conv, t_interp, 'spline');

    %% 2D Plot setup
    cla(ax); hold(ax, 'on');
    hRad  = plot(ax, t_interp(1), T_interp(1), 'r', 'LineWidth', 2);
    hConv = plot(ax, t_interp(1), Tconv_interp(1), 'b', 'LineWidth', 2);
    xlabel(ax, 'Time [s]'); ylabel(ax, 'Temp [K]');
    grid(ax, 'on');
    legend(ax, 'Rad+Conv', 'Conv only');
    title(ax, 'Rod Cooling');
    xlim(ax, [t_interp(1), t_interp(end)]);
    ylim(ax, [min([T_interp, Tconv_interp]), max([T_interp, Tconv_interp])]);

    %% 3D Cylinder setup
    cla(ax3D);
    [X, Y, Z] = cylinder(params.R, 200); % smooth surface
    Z = Z * params.L;
    hSurf = surf(ax3D, X, Y, Z, T_interp(1)*ones(size(Z)));
    colormap(ax3D, 'jet'); colorbar(ax3D);
    caxis(ax3D, [min([T_interp, Tconv_interp]), max([T_interp, Tconv_interp])]);
    axis(ax3D, 'equal'); axis(ax3D, 'off'); view(ax3D, 3);

    %% Animation loop
    for k = 1:nFrames
        % Update 2D plots
        hRad.XData  = t_interp(1:k); hRad.YData  = T_interp(1:k);
        hConv.XData = t_interp(1:k); hConv.YData = Tconv_interp(1:k);

        % Update cylinder color
        hSurf.CData = T_interp(k) * ones(size(Z));

        % Render
        drawnow;
        pause(ts / nFrames); % match slider runtime
    end
end
