clear
close all
load odbicie2KuldoAnalizy.mat
v1=kulka(1).vel;
v2=kulka(2).vel;
m1=kulka(1).r;
m2=kulka(2).r;
x1=[kulka(1).x kulka(1).y];
x2=[kulka(2).x kulka(2).y];
v1New=v1-(2.*m2./(m1+m2)).*(dot(v1-v2,x1-x2)/(norm(x1-x2).^2)).*(x1-x2);
v2New=v2-(2.*m1./(m1+m2)).*(dot(v2-v1,x2-x1)/(norm(x2-x1).^2)).*(x2-x1);
hold on
plot(kulka(1).x,kulka(1).y,'og')
plot(kulka(2).x,kulka(2).y,'ok')
plot([kulka(1).x kulka(1).x+v1New(1)], [kulka(1).y kulka(1).y+v1New(2)],'k')
plot([kulka(2).x kulka(2).x+v2New(1)], [kulka(2).y kulka(2).y+v2New(2)],'k')

offset=abs(kulka(1).r+kulka(2).r-norm([kulka(1).x, kulka(1).y]-[kulka(2).x, kulka(2).y]))/2;
offPos1=[kulka(1).x-kulka(2).x kulka(1).y-kulka(2).y]/norm([kulka(1).x-kulka(2).x kulka(1).y-kulka(2).y]).*offset; 
plot([kulka(1).x kulka(1).x+offPos1(1)],[kulka(1).y kulka(1).y+offPos1(2)],'r')
offPos2=[kulka(2).x-kulka(1).x kulka(2).y-kulka(1).y]/norm([kulka(2).x-kulka(1).x kulka(2).y-kulka(1).y]).*offset; 
plot([kulka(2).x kulka(2).x+offPos2(1)],[kulka(2).y kulka(2).y+offPos2(2)],'b')
hold off