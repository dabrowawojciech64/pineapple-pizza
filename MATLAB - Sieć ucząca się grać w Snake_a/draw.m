function draw(board,snake,apple,alive,score,dir,outN)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

map=[ 1,1,1; %tlo-1
    0,0,0;%sciana-2
    0,1,0;%glowa-3
    0,0.5,0;%tulow-4
    1,0,0;%papu-5
    ];
board(2:end-1,2:end-1)=1;
for i=size(snake,1):-1:1
    j=snake(i,1);
    k=snake(i,2);
    if i==1
        board(j,k)=3;
    else
        board(j,k)=4;
    end
end
m=apple(1);
n=apple(2);
board(m,n)=5;
%board(2:end-1,2:end-1)=randi(5,18);
colormap(map);
image(board,'CDataMapping','direct');
axis image
if alive
   g=sprintf('%d ',whatISee(snake,20,dir));
   d=sprintf('%f ',outN);
   title( sprintf( "Wynik:%.3f. Jablko?:%.3f. Widze:%s, out:%s",score,whereIsApple(snake(1,:),apple,dir),g,d ) );
else
    title(sprintf("Koniec gry. Koñcowy wynik:%.3f",score));
end
%drawnow
%colorbar
end

