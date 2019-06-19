function finalBalls
close all
clear
fig=figure('KeyPressFcn',@Key_Down);

for start=1:6
    
    kulka(start).x = -40 + (40+40)*rand(); %pos x y z
    kulka(start).y= 40*rand();
    kulka(start).newX = kulka(start).x;
    kulka(start).newY = kulka(start).y;
    kulka(start).vel = [-0.5 + (0.5+0.5)*rand(), 0];
    kulka(start).vI=[0 0];
    kulka(start).newVel=kulka(start).vel;
    kulka(start).r= 1 + rand(); %promien
    kulka(start).tmp=[0, 0];
    if mod(start,2)
        kulka(start).rgb=[1,0,0];
    else
        kulka(start).rgb=[0,0,1];
    end
end
viscircles([[kulka.x]',[kulka.y]'],[kulka.r]);
axis([-50 50 -50 50])
axis square
cooldown=5;
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
            
            kulka(i).newVel=odbicie*speed.*0.8;
            kulka(i).newX=kulka(i).x+(-kulka(i).vI(1)*d)+kulka(i).vel(1)+kulka(i).newVel(1);
            kulka(i).newY=kulka(i).y+(-kulka(i).vI(2)*d)+kulka(i).vel(2)+kulka(i).newVel(2);
            
        end
        
        if (0.6*(kulka(i).x+kulka(i).vel(1)+posR(1))-(kulka(i).y+kulka(i).vel(2)+posR(2))-50)/1.166190378969060>=0
            %cos sie dzieje
            
            d=(0.6*(kulka(i).x+kulka(i).vel(1)+posR(1))-(kulka(i).y+kulka(i).vel(2)+posR(2))-50)/1.166190378969060;
            n=[-0.6 1];
            nI=n/norm(n);
            odbicie=kulka(i).vI-2.*dot(kulka(i).vI,nI)*nI;
            kulka(i).newVel=odbicie*speed.*0.8;
            
            
            
        end
        if kulka(i).x~=kulka(i).newX || kulka(i).y~=kulka(i).newY
            kulka(i).x=kulka(i).newX;
            kulka(i).y=kulka(i).newY;
        else
            kulka(i).x=kulka(i).newX+kulka(i).newVel(1);
            kulka(i).y=kulka(i).newY+kulka(i).newVel(2);
        end
        
        kulka(i).vel=kulka(i).newVel;
        kulka(i).vel(2)=kulka(i).vel(2)-0.1;
    end
    if numel(kulka)>1
        pairs=nchoosek(1:numel(kulka),2);
        for j=1:size(pairs,1)
            
            one=pairs(j,1);
            two=pairs(j,2);
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
                kulka(two).x=kulka(two).x+offPos2(1)+kulka(two).vel(1);
                kulka(two).y=kulka(two).y+offPos2(2)+kulka(two).vel(2);
                kolorA=rgb2hsv(kulka(one).rgb);
                kolorB=rgb2hsv(kulka(two).rgb);
                newColor=mean([kolorA;kolorB]);
                kulka(one).rgb=hsv2rgb(newColor);
                kulka(two).rgb=hsv2rgb(newColor);
            end
        end
    end
    fill([-50 0 50 50 -50 -50],[-20 -50 -20 -50 -50 -20],[0 0 0]);
    axis([-50 50 -50 50])
    axis square
    hold on
    for k=1:numel(kulka)
        viscircles([kulka(k).x kulka(k).y],[kulka(k).r],'LineWidth',1,'Color',[kulka(k).rgb]);
    end
    hold off
    set(gca,'Color',[0.2 0.2 0.2])
    %     axis([-50 50 -50 50])
    
    drawnow
    
    
    while toc(timer)<=1/60
        if cooldown==0
            drawnow
        end
    end
    if cooldown>0
        cooldown=cooldown-1;
    end
    
end
    function Key_Down(src,event)
        
        cur_ch = sprintf('%c',event.Key);
        if cooldown==0
            switch cur_ch
                case 'leftarrow'
                    next=numel(kulka)+1;
                    kulka(next).x = -40 + (-20+40)*rand(); %pos x y z
                    kulka(next).y= 40*rand();
                    kulka(next).newX = kulka(next).x;
                    kulka(next).newY = kulka(next).y;
                    kulka(next).vel = [-1 + (1+1)*rand(), 0];
                    kulka(next).vI=[0 0];
                    kulka(next).newVel=kulka(next).vel;
                    kulka(next).r= 1 + rand(); %promien
                    kulka(next).tmp=[0, 0];
                    kulka(next).rgb=[1,0,0];
                    cooldown=5;
                case 'downarrow'
                    next=numel(kulka)+1;
                    kulka(next).x = -20 + (20+20)*rand(); %pos x y z
                    kulka(next).y= 40*rand();
                    kulka(next).newX = kulka(next).x;
                    kulka(next).newY = kulka(next).y;
                    kulka(next).vel = [-1 + (1+1)*rand(), 0];
                    kulka(next).vI=[0 0];
                    kulka(next).newVel=kulka(next).vel;
                    kulka(next).r= 1 + rand(); %promien
                    kulka(next).tmp=[0, 0];
                    kulka(next).rgb=[0,1,0];
                    cooldown=5;
                case 'rightarrow'
                    next=numel(kulka)+1;
                    kulka(next).x = 20 + (40-20)*rand(); %pos x y z
                    kulka(next).y= 40*rand();
                    kulka(next).newX = kulka(next).x;
                    kulka(next).newY = kulka(next).y;
                    kulka(next).vel = [-1 + (1+1)*rand(), 0];
                    kulka(next).vI=[0 0];
                    kulka(next).newVel=kulka(next).vel;
                    kulka(next).r= 1 + rand(); %promien
                    kulka(next).tmp=[0, 0];
                    kulka(next).rgb=[0,0,1];
                    cooldown=5;
                    
                case 'k'
                    if numel(kulka)> 1
                        predkosci=[];
                        for z=1:numel(kulka)
                            predkosci=[predkosci, norm(kulka(z).vel)];
                            
                        end
                        [~,idx]=min(predkosci);
                        kulka(idx)=[];
                    end
            end
        end
    end


end

