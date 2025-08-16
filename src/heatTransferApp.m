
% Rod Cooling Simulation
% Smooth UI animation with sliders


%% Close previous figure
figs = findall(0, 'Type', 'figure', 'Name', 'Rod Cooling Simulation');
if ~isempty(figs)
    close(figs)
end

%% Create UIFigure
fig = uifigure('Name', 'Rod Cooling Simulation', 'Position', [100 100 1200 600]);

%% Axes for 2D temperature plots
ax = uiaxes(fig, 'Position', [50 250 700 300]);
xlabel(ax, 'Time [s]');
ylabel(ax, 'Temperature [K]');
grid(ax, 'on');

%% Axes for 3D cylinder
ax3D = uiaxes(fig, 'Position', [780 250 300 300]);
view(ax3D, 3);
axis(ax3D, 'equal');
axis(ax3D, 'off');

%% Sliders
% Initial Temperature
sT0 = uislider(fig, 'Position', [150 170 400 3], 'Limits', [350 1000], 'Value', 500);
lblT0 = uilabel(fig, 'Position', [60 160 100 22], 'Text', 'T0 [K]');
sT0.Tooltip = 'Initial rod temperature';

% Convection coefficient
sh = uislider(fig, 'Position', [700 170 400 3], 'Limits', [10 200], 'Value', 40);
lblh = uilabel(fig, 'Position', [610 160 100 22], 'Text', 'h [W/m²K]');
sh.Tooltip = 'Convection coefficient';

% Runtime (seconds)
st = uislider(fig, 'Position', [150 120 400 3], 'Limits', [1 30], 'Value', 10);
lblt = uilabel(fig, 'Position', [60 110 120 22], 'Text', 'Runtime [s]');
st.Tooltip = 'Animation runtime';

% Radiation emissivity
seps = uislider(fig, 'Position', [700 120 400 3], 'Limits', [0 1], 'Value', 0.5);
lbeps = uilabel(fig, 'Position', [610 110 100 22], 'Text', 'eps');
seps.Tooltip = 'Radiation emissivity';

%% Update Button
btn = uibutton(fig, 'push', 'Text', 'Update Plot', 'Position', [570 20 120 40], ...
    'ButtonPushedFcn', @(btn,event) updatePlot(ax, ax3D, sT0.Value, sh.Value, seps.Value, st.Value));

%% Initial plot
updatePlot(ax, ax3D, sT0.Value, sh.Value, seps.Value, st.Value);