function [fitresult, gof] = findfit(Z2)
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

%  Auto-generated by MATLAB on 15-Apr-2014 18:41:24


%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( [], Z2 );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 1.5029271581647606E-4;
%opts.SmoothingParam = 3.3538753662983465E-5;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

%New code
yfitted = feval(fitresult,xData);
plot(xData,yData,xData,yfitted)
[ypk,idx] = findpeaks(yfitted);
xpk = xData(idx);
hold on;
plot(xpk,ypk,'r');

% % Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, xData, yData );
% legend( h, 'Z2', 'untitled fit 1', 'Location', 'NorthEast' );
% % Label axes
% ylabel( 'Z2' );
% grid on

