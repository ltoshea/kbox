%Constructs smooth spine curve,
%Finds locam minima and maxima on smoothed curve

function [zmax,zmin,imax,imin] = findfit2(Z2)

% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( [], Z2 );

% Set up fittype and options.
ft = fittype( 'smoothingspline' );
opts = fitoptions( 'Method', 'SmoothingSpline' );
opts.SmoothingParam = 1.5029271581647606E-4;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

yfitted = feval(fitresult,xData);
[zmax,imax,zmin,imin] = extrema(yfitted);
hold on;
plot((imax),zmax,'r*',(imin),zmin,'g*')
%plot(xData,yData,xData,yfitted)
plot(xData,yfitted);

% [ypk,idx] = findpeaks(yfitted);
% xpk = xData(idx);
% hold on
% plot(xpk,ypk,'o')

% % Plot fit with data.
% figure( 'Name', 'untitled fit 1' );
% h = plot( fitresult, xData, yData );
% legend( h, 'Z2', 'untitled fit 1', 'Location', 'NorthEast' );
% % Label axes
% ylabel( 'Z2' );
% grid on


