i=1;
kulka(1).x = 30; %pos x y z
kulka(1).y= -10;
kulka(1).newX = kulka.x;
kulka(1).newY = kulka.x;
kulka(1).vel = [2.75, 0];
kulka(1).newVel=kulka(1).vel;
kulka(1).r= 1; %promien
kulka(1).tmp=[0, 0];




kulka(i).newVel=kulka(i).vel;
kulka(i).newX=kulka(i).x;
kulka(i).newY=kulka(i).y;
kulka(i).tmp=[0,0];

if kulka(i).x+kulka(i).r+kulka(i).vel(1)>=50
    kulka(i).tmp(1)=(50-(kulka(i).x+kulka(i).r+kulka(i).vel(1)))*2;
    kulka(i).newVel(1)=-kulka(i).vel(1).*0.95;
    kulka(i).newX=kulka(i).newX+kulka(i).vel(1)+kulka(i).tmp(1);
end
if kulka(i).y+kulka(i).r+kulka(i).vel(2)>=50
    kulka(i).tmp(2)=(50-(kulka(i).y+kulka(i).r+kulka(i).vel(2)))*2;
    kulka(i).newVel(2)=-kulka(i).vel(2).*0.95;
    kulka(i).newY=kulka(i).newY+kulka(i).vel(2)+kulka(i).tmp(2);
end
if kulka(i).x-kulka(i).r+kulka(i).vel(1)<=-50
    kulka(i).tmp(1)=(-50-(kulka(i).x-kulka(i).r+kulka(i).vel(1)))*2;
    kulka(i).newVel(1)=-kulka(i).vel(1).*0.95;
    kulka(i).newX=kulka(i).newX+kulka(i).vel(1)+kulka(i).tmp(1);
end
if kulka(i).y-kulka(i).r+kulka(i).vel(2)<=-50
    kulka(i).tmp(2)=(-50-(kulka(i).y-kulka(i).r+kulka(i).vel(2)))*2;
    kulka(i).newVel(2)=-kulka(i).vel(2).*0.95;
    kulka(i).newY=kulka(i).newY+kulka(i).vel(2)+kulka(i).tmp(2);
end
speed=norm(kulka(i).vel);
vI=kulka(i).vel/speed;
posR=vI*kulka(i).r;
if (-0.6*(kulka(i).x+kulka(i).vel(1)+posR(1))-(kulka(i).y+kulka(i).vel(2)+posR(2))-50)/1.166190378969060 >=0
    %cos sie dzieje
    d=(-0.6*(kulka(i).x+kulka(i).vel(1)+posR(1))-(kulka(i).y+kulka(i).vel(2)+posR(2))-50)/1.166190378969060;
    n=[0.6 1];
    
    nI=n/norm(n);
    odbicie=vI-2.*dot(vI,nI)*nI;
    
    kulka(i).newVel=odbicie*speed.*1.005;
    kulka(i).newX=kulka(i).x+(-vI(1)*d)+kulka(i).vel(1)+kulka(i).newVel(1);
    kulka(i).newY=kulka(i).y+(-vI(2)*d)+kulka(i).vel(2)+kulka(i).newVel(2);
    
end

if (0.6*(kulka(i).x+kulka(i).vel(1)+posR(1))-(kulka(i).y+kulka(i).vel(2)+posR(2))-50)/1.166190378969060>=0
    %cos sie dzieje
    
    d=(0.6*(kulka(i).x+kulka(i).vel(1)+posR(1))-(kulka(i).y+kulka(i).vel(2)+posR(2))-50)/1.166190378969060;
    n=[-0.6 1];
    nI=n/norm(n);
    odbicie=vI-2.*dot(vI,nI)*nI;
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
cla
%         viscircles(kulka(i).x,kulka(i).r);

