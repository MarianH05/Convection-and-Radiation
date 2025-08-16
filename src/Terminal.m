function [value, isterminal, direction] = Terminal(~, T,params)
value = T - (params.Tfinal); % Stop when T reaches Tinf + 1
isterminal = 1; % Stop the integration
direction = 0; % All directions
end