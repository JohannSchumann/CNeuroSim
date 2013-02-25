%	plot raster plot of neuon activity
%
%	FN: name of file to save figure
%	sim: sim structure 
%	off: temporal offset; 0 = start at beginning
%	theend: end of interval to display; 0 = display all
%
%	$Revision:$
%
function  plot_raster_graph(FN, sim, off, theend)

if (off == 0),
	off = 1;
	end;

if (theend == 0),
	theend = sim.T_upd;
	end;


N =sim.N_nn;

figure;

%--------------------------------------------
%--------------------------------------------
firact = zeros(1,N);
ti=1:sim.T_upd-off+1;
hold off;
for i=1:sim.N_nn,
        sp=find(sim.instrument.allvm(1,i,off:theend) > sim.activity_thr);
	fireact(i)=length(sp);
        if (length(sp) > 0),
                spp=zeros(1,length(sp))+i;
                plot(ti(sp),spp,'.','MarkerSize',15);
		hold('on');
        end;
        end;

axis([1,sim.T_upd-off,1,sim.N_nn+1]);
set(gca,'Visible','off');

%------------------------------------------------------------------
% print the stuff to file
%------------------------------------------------------------------
fn_eps =sprintf('%s.eps', FN);
print('-depsc', fn_eps);
fn_jpg =sprintf('%s.jpg', FN);
print('-djpeg', fn_jpg);
fn_tiff =sprintf('%s.tiff', FN);
print('-dtiff', fn_tiff);
fn_png =sprintf('%s.png', FN);
print('-dpng','-r150', fn_png);

