close all
clear
fig=figure(1);
kulka(1).x = -47; %pos x
kulka(1).y = 20; %pos y
kulka(1).vel = [-1, 1.621];
kulka(1).r= 1; %promien
kulka(1).tmp=[0, 0];
kulka(2).x = 47; %pos x
kulka(2).y = -20; %pos y
kulka(2).vel = [1, -1.621];
kulka(2).r= 5; %promien
kulka(2).tmp=[0, 0];
viscircles([[kulka.x]',[kulka.y]'],[kulka.r]);
axis([-50 50 -50 50])
axis square
while true && ishandle(fig)
    cla
    for i=1:numel(kulka)
        kulka(i).tmp=[0,0];
        
        if kulka(i).x+kulka(i).r+kulka(i).vel(1)>=50
            kulka(i).tmp(1)=(50-(kulka(i).x+kulka(i).r+kulka(i).vel(1)))*2;
        end
        if kulka(i).y+kulka(i).r+kulka(i).vel(2)>=50
            kulka(i).tmp(2)=(50-(kulka(i).y+kulka(i).r+kulka(i).vel(2)))*2;
        end
        if kulka(i).x-kulka(i).r+kulka(i).vel(1)<=-50
            kulka(i).tmp(1)=(-50-(kulka(i).x-kulka(i).r+kulka(i).vel(1)))*2;
        end
        if kulka(i).y-kulka(i).r+kulka(i).vel(2)<=-50
            kulka(i).tmp(2)=(-50-(kulka(i).y-kulka(i).r+kulka(i).vel(2)))*2;
        end
        kulka(i).x =kulka(i).x+kulka(i).vel(1)+kulka(i).tmp(1);
         kulka(i).y =kulka(i).y+kulka(i).vel(2)+kulka(i).tmp(2);
        kulka(i).vel(kulka(i).tmp~=0)=kulka(i).vel(kulka(i).tmp~=0).*(-0.95);
        kulka(i).vel(2)=kulka(i).vel(2)-0.2;
    end
    viscircles([[kulka.x]',[kulka.y]'],[kulka.r]);
%     hold on
%     fill([-50 0 50 50 -50 -50],[-20 -50 -20 -50 -50 -20],[0 0 0]);
%     hold off
    drawnow
    pause(1/60)
end

