function [fitresult, gof] = createFit(Z2)
%CREATEFIT(Z2)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      Y Output: Z2
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 15-Apr-2014 18:38:49


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( [], Z2 );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 0.000684876001604022;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'Z2', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
ylabel( 'Z2' );
grid on


