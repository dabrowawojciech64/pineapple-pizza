close all
clear
fig=figure(1);
kulka.pos = [30, -10]; %pos x y z
kulka.newPos = kulka.pos;
kulka.vel = [2.75, 0];
kulka.newVel=kulka.vel;
kulka.r= 1; %promien
kulka.tmp=[0, 0];
viscircles(kulka.pos,kulka.r);
axis([-50 50 -50 50])
axis square
while true && ishandle(fig)
    
    kulka.newVel=kulka.vel;
    kulka.newPos=kulka.pos;
    kulka.tmp=[0,0];
    
    if kulka.pos(1)+kulka.r+kulka.vel(1)>=50
        kulka.tmp(1)=(50-(kulka.pos(1)+kulka.r+kulka.vel(1)))*2;
        kulka.newVel(1)=-kulka.vel(1).*0.95;
        kulka.newPos(1)=kulka.newPos(1)+kulka.vel(1)+kulka.tmp(1);
    end
    if kulka.pos(2)+kulka.r+kulka.vel(2)>=50
        kulka.tmp(2)=(50-(kulka.pos(2)+kulka.r+kulka.vel(2)))*2;
        kulka.newVel(2)=-kulka.vel(2).*0.95;
        kulka.newPos(2)=kulka.newPos(2)+kulka.vel(2)+kulka.tmp(2);
    end
    if kulka.pos(1)-kulka.r+kulka.vel(1)<=-50
        kulka.tmp(1)=(-50-(kulka.pos(1)-kulka.r+kulka.vel(1)))*2;
        kulka.newVel(1)=-kulka.vel(1).*0.95;
        kulka.newPos(1)=kulka.newPos(1)+kulka.vel(1)+kulka.tmp(1);
    end
    if kulka.pos(2)-kulka.r+kulka.vel(2)<=-50
        kulka.tmp(2)=(-50-(kulka.pos(2)-kulka.r+kulka.vel(2)))*2;
        kulka.newVel(2)=-kulka.vel(2).*0.95;
        kulka.newPos(2)=kulka.newPos(2)+kulka.vel(2)+kulka.tmp(2);
    end
    speed=norm(kulka.vel);
    vI=kulka.vel/speed;
    posR=vI*kulka.r;% przesuniecie do punktu styku
    
%     (-0.6*(kulka.pos(1)+kulka.vel(1)+posR(1))-(kulka.pos(2)+kulka.vel(2)+posR(2))-50)/1.166190378969060
    %      (-0.6*(kulka.pos(1)+kulka.vel(1))-(kulka.pos(2)+kulka.vel(2))-50)/1.166190378969060
    if (-0.6*(kulka.pos(1)+kulka.vel(1)+posR(1))-(kulka.pos(2)+kulka.vel(2)+posR(2))-50)/1.166190378969060 >=0
        %cos sie dzieje
        d=(-0.6*(kulka.pos(1)+kulka.vel(1)+posR(1))-(kulka.pos(2)+kulka.vel(2)+posR(2))-50)/1.166190378969060;
        n=[0.6 1];
%         hold on
%         viscircles(kulka.pos+kulka.vel,kulka.r,'color','b');
        
         nI=n/norm(n);
         odbicie=vI-2.*dot(vI,nI)*nI;
%          xF=[kulka.pos(1) kulka.pos(1)+kulka.vel(1)+odbicie(1)*speed];
%          yF=[kulka.pos(2) kulka.pos(2)+kulka.vel(2)+odbicie(2)*speed];
%          plot(xF,yF);
         kulka.newVel=odbicie*speed.*1.005;
%          xAgain=[kulka.pos(1)+(-vI(1)*d),kulka.pos(1)+(-vI(1)*d)+kulka.vel(1)+kulka.newVel(1)];
%          yAgain=[kulka.pos(2)+(-vI(2)*d),kulka.pos(2)+(-vI(2)*d)+kulka.vel(2)+kulka.newVel(2)];
         kulka.newPos=kulka.pos+(-vI*d)+kulka.vel+kulka.newVel;
         %again(2)FINALNA POZYCJA PO ODBICIU. Uda ci sie to zrobiæ wierzê w ciebie
%          hold off
%         axis([-50 50 -50 50])
%         axis image
         %return vector - 2 * Vector2.Dot(vector, normal) * normal;
    end
    
    if (0.6*(kulka.pos(1)+kulka.vel(1)+posR(1))-(kulka.pos(2)+kulka.vel(2)+posR(2))-50)/1.166190378969060>=0
        %cos sie dzieje
        
       d=(0.6*(kulka.pos(1)+kulka.vel(1)+posR(1))-(kulka.pos(2)+kulka.vel(2)+posR(2))-50)/1.166190378969060;
        n=[-0.6 1];
%         hold on
%         viscircles(kulka.pos+kulka.vel,kulka.r,'color','b');
        
         nI=n/norm(n);
         odbicie=vI-2.*dot(vI,nI)*nI;
%          xF=[kulka.pos(1) kulka.pos(1)+kulka.vel(1)+odbicie(1)*speed];
%          yF=[kulka.pos(2) kulka.pos(2)+kulka.vel(2)+odbicie(2)*speed];
%          plot(xF,yF);
         kulka.newVel=odbicie*speed.*1.005;
%          xAgain=[kulka.pos(1)+(-vI(1)*d),kulka.pos(1)+(-vI(1)*d)+kulka.vel(1)+kulka.newVel(1)];
%          yAgain=[kulka.pos(2)+(-vI(2)*d),kulka.pos(2)+(-vI(2)*d)+kulka.vel(2)+kulka.newVel(2)];
         kulka.newPos=kulka.pos+(-vI*d)+kulka.vel+kulka.newVel;
         
    end
    if any(kulka.pos~=kulka.newPos)
    kulka.pos=kulka.newPos;
    else
        kulka.pos=kulka.newPos+kulka.newVel;
    end
    
    kulka.vel=kulka.newVel;
    kulka.vel(2)=kulka.vel(2)-0.2;
    cla
    viscircles(kulka.pos,kulka.r);
   
    axis([-50 50 -50 50])
    axis square
    hold on
     fill([-50 0 50 50 -50 -50],[-20 -50 -20 -50 -50 -20],[0 0 0]);
    hold off
    
    %     axis([-50 50 -50 50])
    
    drawnow
    
    pause(1/60)
end

