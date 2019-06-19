close all
clear
fig=figure(1);
kulka(1).x = 30; %pos x y z
kulka(1).y= -10;
kulka(1).newX = kulka(1).x;
kulka(1).newY = kulka(1).y;
kulka(1).vel = [2.75, 0];
kulka(1).vI=[0 0];
kulka(1).newVel=kulka(1).vel;
kulka(1).r= 1; %promien
kulka(1).tmp=[0, 0];
kulka(1).rgb=[1,0,0];
kulka(2).x = -30; %pos x y z
kulka(2).y= -10;
kulka(2).newX = kulka(2).x;
kulka(2).newY = kulka(2).y;
kulka(2).vel = [-2.75, 0];
kulka(2).vI=[0 0];
kulka(2).newVel=kulka(1).vel;
kulka(2).r= 5; %promien
kulka(2).tmp=[0, 0];
kulka(2).rgb=[0,1,0];
kulka(3).x = 0; %pos x y z
kulka(3).y= 30;
kulka(3).newX = kulka(3).x;
kulka(3).newY = kulka(3).y;
kulka(3).vel = [1, 0];
kulka(3).vI=[0 0];
kulka(3).newVel=kulka(1).vel;
kulka(3).r= 3; %promien
kulka(3).tmp=[0, 0];
kulka(3).rgb=[0,0,1];
viscircles([[kulka.x]',[kulka.y]'],[kulka.r]);
axis([-50 50 -50 50])
axis square
while true && ishandle(fig)
    cla
    timer=tic();
    for i=1:numel(kulka)
        kulka(i).newVel=kulka(i).vel;
        kulka(i).newX=kulka(i).x;
        kulka(i).newY=kulka(i).y;
        kulka(i).tmp=[0,0];
        
        if kulka(i).x+kulka(i).r+kulka(i).vel(1)>=50
            kulka(i).tmp(1)=(50-(kulka(i).x+kulka(i).r+kulka(i).vel(1)))*2;
            kulka(i).newVel(1)=-kulka(i).vel(1).*0.9;
            kulka(i).newX=kulka(i).newX+kulka(i).vel(1)+kulka(i).tmp(1);
        end
        if kulka(i).y+kulka(i).r+kulka(i).vel(2)>=50
            kulka(i).tmp(2)=(50-(kulka(i).y+kulka(i).r+kulka(i).vel(2)))*2;
            kulka(i).newVel(2)=-kulka(i).vel(2).*0.9;
            kulka(i).newY=kulka(i).newY+kulka(i).vel(2)+kulka(i).tmp(2);
        end
        if kulka(i).x-kulka(i).r+kulka(i).vel(1)<=-50
            kulka(i).tmp(1)=(-50-(kulka(i).x-kulka(i).r+kulka(i).vel(1)))*2;
            kulka(i).newVel(1)=-kulka(i).vel(1).*0.9;
            kulka(i).newX=kulka(i).newX+kulka(i).vel(1)+kulka(i).tmp(1);
        end
        if kulka(i).y-kulka(i).r+kulka(i).vel(2)<=-50
            kulka(i).tmp(2)=(-50-(kulka(i).y-kulka(i).r+kulka(i).vel(2)))*2;
            kulka(i).newVel(2)=-kulka(i).vel(2).*0.9;
            kulka(i).newY=kulka(i).newY+kulka(i).vel(2)+kulka(i).tmp(2);
        end
        speed=norm(kulka(i).vel);
        kulka(i).vI=kulka(i).vel/speed;
        posR=kulka(i).vI*kulka(i).r;
        if (-0.6*(kulka(i).x+kulka(i).vel(1)+posR(1))-(kulka(i).y+kulka(i).vel(2)+posR(2))-50)/1.166190378969060 >=0
            %cos sie dzieje
            d=(-0.6*(kulka(i).x+kulka(i).vel(1)+posR(1))-(kulka(i).y+kulka(i).vel(2)+posR(2))-50)/1.166190378969060;
            n=[0.6 1];
            
            nI=n/norm(n);
            odbicie=kulka(i).vI-2.*dot(kulka(i).vI,nI)*nI;
            
            kulka(i).newVel=odbicie*speed.*1.005;
            kulka(i).newX=kulka(i).x+(-kulka(i).vI(1)*d)+kulka(i).vel(1)+kulka(i).newVel(1);
            kulka(i).newY=kulka(i).y+(-kulka(i).vI(2)*d)+kulka(i).vel(2)+kulka(i).newVel(2);
            
        end
        
        if (0.6*(kulka(i).x+kulka(i).vel(1)+posR(1))-(kulka(i).y+kulka(i).vel(2)+posR(2))-50)/1.166190378969060>=0
            %cos sie dzieje
            
            d=(0.6*(kulka(i).x+kulka(i).vel(1)+posR(1))-(kulka(i).y+kulka(i).vel(2)+posR(2))-50)/1.166190378969060;
            n=[-0.6 1];
            nI=n/norm(n);
            odbicie=kulka(i).vI-2.*dot(kulka(i).vI,nI)*nI;
            kulka(i).newVel=odbicie*speed.*1.005;
            
            
            
        end
        if kulka(i).x~=kulka(i).newX || kulka(i).y~=kulka(i).newY
            kulka(i).x=kulka(i).newX;
            kulka(i).y=kulka(i).newY;
        else
            kulka(i).x=kulka(i).newX+kulka(i).newVel(1);
            kulka(i).y=kulka(i).newY+kulka(i).newVel(2);
        end
        
        kulka(i).vel=kulka(i).newVel;
        kulka(i).vel(2)=kulka(i).vel(2)-0.2;
    end
    pairs=nchoosek(1:numel(kulka),2);
    for j=1:size(pairs,1)
        one=pairs(i,1);
        two=pairs(i,2);
        if norm([kulka(one).x, kulka(one).y]-[kulka(two).x, kulka(two).y]) <= kulka(one).r+kulka(two).r
            kulka(one).vI=kulka(one).vel/norm(kulka(one).vel);
            kulka(two).vI=kulka(two).vel/norm(kulka(two).vel);
            v1=kulka(one).vel;
            v2=kulka(two).vel;
            m1=kulka(one).r;
            m2=kulka(two).r;
            x1=[kulka(one).x kulka(one).y];
            x2=[kulka(two).x kulka(two).y];
            v1New=v1-(2.*m2./(m1+m2)).*(dot(v1-v2,x1-x2)/(norm(x1-x2).^2)).*(x1-x2);
            v2New=v2-(2.*m1./(m1+m2)).*(dot(v2-v1,x2-x1)/(norm(x2-x1).^2)).*(x2-x1);
            offset=abs(kulka(one).r+kulka(two).r-norm([kulka(one).x, kulka(one).y]-[kulka(two).x, kulka(two).y]))/2;
            offPos1=[kulka(one).x-kulka(two).x kulka(one).y-kulka(two).y]/norm([kulka(one).x-kulka(two).x kulka(one).y-kulka(two).y]).*offset;
            offPos2=[kulka(two).x-kulka(one).x kulka(two).y-kulka(one).y]/norm([kulka(two).x-kulka(one).x kulka(two).y-kulka(one).y]).*offset;
            kulka(one).vel=v1New;
            kulka(two).vel=v2New;
            kulka(one).x=kulka(one).x+offPos1(1)+kulka(one).vel(1);
            kulka(one).y=kulka(one).y+offPos1(2)+kulka(1).vel(2);
            kulka(two).x=kulka(two).x+offPos1(1)+kulka(two).vel(1);
            kulka(two).y=kulka(two).y+offPos1(2)+kulka(two).vel(2);
        end
    end
    fill([-50 0 50 50 -50 -50],[-20 -50 -20 -50 -50 -20],[0 0 0]);
    viscircles([[kulka.x]',[kulka.y]'],[kulka.r],'LineWidth',1);
    axis([-50 50 -50 50])
    axis square
    hold on
    for k=1:numel(kulka)
    viscircles([kulka(k).x kulka(k).y],[kulka(k).r],'LineWidth',1,'Color',[kulka(k).rgb]);
    end
    hold off
    
    %     axis([-50 50 -50 50])
    
    drawnow
    
    
    if toc(timer)<=1/30
        pause(1/30-toc(timer))
    end
end

