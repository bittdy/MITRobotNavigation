t=plot([2,1],[0,1]);
i=1;
while 1
    set(t,'XData',[2+i,1+i],'YData',[0+i,1+i]);
    i=i+1;
    pause(0.1);
end