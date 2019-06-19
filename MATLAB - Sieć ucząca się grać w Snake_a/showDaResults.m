
close all
%todo dane treningowe ogarnac
%% init
fig=figure();
fps=15;
frameTime=1/fps;
boardSize=20;
growth=3;%o ile rosnie w¹¿ gdy zje papu
board=ones(boardSize);
snakeLength=5;
snake=[round(boardSize/2) round(boardSize/2)];
%apple=generateApple(snake,boardSize);
apple=genApple(snake,boardSize);
direction=1;
board(1:end,1)=2;
board(1,1:end)=2;
board(end,1:end)=2;
board(1:end,end)=2;
score=0;
alive=true;
waiting=false;
y=[420 69 42];
draw(board,snake,apple,alive,score,direction,y);
load net.mat








while(alive && ishandle(fig))
    %for lol=1:15
    if(ishandle(fig))
       draw(board,snake,apple,alive,score,direction,y)
    end
    lastDirection=direction;
    appleAngle=whereIsApple(snake(1,:),apple,direction);
    timer=tic;
    waiting=true;
    while toc(timer)<=frameTime
        if waiting
            drawnow
        end
    end
    %sprintf('LastDir=%d, Dir=%d',lastDirection,direction)
    waiting=false;
    senses=whatISee(snake,boardSize,direction)';
    y=sim(net,[senses;appleAngle]);
    
    %0-1 w ktora strone skret y[straight,left,right]
    decision=round(y);
    
    if decision(2)&&decision(3)
        direction=lastDirection;
    elseif decision(2)
        direction=mod(lastDirection-1,4);
    elseif decision(3)
        direction=mod(lastDirection+1,4);
    end
    % if toc(timer)<=frameTime
    %     pause(frameTime-toc(timer))
    %  end  
    %% Poruszanie sie
    %y+ - prawo direction=0
    %x+ = dó³ direction=1
    %y- =lewo direction=2
    %x- = góra direction=3
    
    if direction==0
        newsnake=[snake(1,1),snake(1,2)+1];
    elseif direction==1
        newsnake=[snake(1,1)+1,snake(1,2)];
    elseif direction==2
        newsnake=[snake(1,1),snake(1,2)-1];
    elseif direction==3
        newsnake=[snake(1,1)-1,snake(1,2)];
    end
%     if direction==lastDirection
%         y=[1,0,0];
%     elseif direction==mod(lastDirection-1,4)
%         y=[0,1,0];
%     elseif direction==mod(lastDirection+1,4)
%         y=[0,0,1];
%     end
    if any(newsnake==1)||any(newsnake==boardSize)
        alive=false;
        
    end
    if any(snake(:, 1) == newsnake(1) & snake(:, 2) == newsnake(2))
        alive=false;
        
    end
    %senses=whatISee(snake,boardSize,lastDirection);
    %if alive
    %training=[training;senses,appleAngle,y];
    %111end
    snake=[newsnake;snake];
    
    
    
    if all(snake(1,:)==apple)
        snakeLength=snakeLength+growth;
        apple=genApple(snake,boardSize);
        score=score+1000;
    end
    
    score=score+1-2*abs(whereIsApple(snake(1,:),apple,direction));
    if size(snake,1)>snakeLength
        snake=snake(1:snakeLength,:);
    end
    
    %     %% W wyœwietlanie na dole
    %     board(2:end-1,2:end-1)=1;
    %     for i=1:size(snake,1)
    %         j=snake(i,1);
    %         k=snake(i,2);
    %         if i==1
    %             board(j,k)=3;
    %         else
    %             board(j,k)=4;
    %         end
    %     end
    %     m=apple(1);
    %     n=apple(2);
    %     board(m,n)=5;
    %     %board(2:end-1,2:end-1)=randi(5,18);
    %     colormap(map)
    %     image(board,'CDataMapping','direct')
    %     axis image
    %     drawnow
    %     %colorbar
    
end
if ishandle(fig)
    draw(board,snake,apple,alive,score,direction)
    drawnow
end
save('training.mat','training');
