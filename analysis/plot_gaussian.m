%
%	plot a Gaussian bell shape
%
%
%	$Revision:$

function plot_gaussian(fn, m, s)


xmin=min(m)-max(s);
xmax=max(m)+max(s);
%x=-2:0.005:2;
x=xmin:(xmax-xmin)/500:xmax;

figure;
for i=1:length(m),
	y=(1/sqrt(2*pi*s(i)))*exp(-((x-m(i)).^2)/s(i));
%	plot(x,y,'*');
	plot(x,y,'Linewidth',2);
	hold on;
	end;

hold off;

%axis([-2,2,0,0.4]);

fn_eps = sprintf('%s.eps', fn);
print('-deps2',fn_eps);
fn_jpg = sprintf('%s.jpg', fn);
print('-djpeg',fn_jpg);

