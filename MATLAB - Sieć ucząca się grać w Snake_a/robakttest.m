function robakttest
close all
%todo dane treningowe ogarnac
%% init
fig=figure('KeyPressFcn',@Key_Down);
fps=7;
frameTime=1/fps;
boardSize=20;
growth=3;%o ile rosnie w�� gdy zje papu
board=ones(boardSize);
snakeLength=3;
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
out=[420 69 42];
draw(board,snake,apple,alive,score,direction,out);




if exist('training.mat')
    load training.mat
else
    training=[];
end



while(alive && ishandle(fig))
    %for lol=1:15
    if(ishandle(fig))
       draw(board,snake,apple,alive,score,direction,out)
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
    %0-1 w ktora strone skret out[straight,left,right]
    
    % if toc(timer)<=frameTime
    %     pause(frameTime-toc(timer))
    %  end  
    %% Poruszanie sie
    %y+ - prawo direction=0
    %x+ = d� direction=1
    %y- =lewo direction=2
    %x- = g�ra direction=3
    
    if direction==0
        newsnake=[snake(1,1),snake(1,2)+1];
    elseif direction==1
        newsnake=[snake(1,1)+1,snake(1,2)];
    elseif direction==2
        newsnake=[snake(1,1),snake(1,2)-1];
    elseif direction==3
        newsnake=[snake(1,1)-1,snake(1,2)];
    end
    if direction==lastDirection
        out=[1,0,0];
    elseif direction==mod(lastDirection-1,4)
        out=[0,1,0];
    elseif direction==mod(lastDirection+1,4)
        out=[0,0,1];
    end
    if any(newsnake==1)||any(newsnake==boardSize)
        alive=false;
        
    end
    if any(snake(:, 1) == newsnake(1) & snake(:, 2) == newsnake(2))
        alive=false;
        
    end
    senses=whatISee(snake,boardSize,lastDirection);
    if alive
    training=[training;senses,appleAngle,out];
    end
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
    
    %     %% W wy�wietlanie na dole
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

    function Key_Down(src,event)
        
        cur_ch = sprintf('%c',event.Key);
        if waiting
            switch cur_ch
                case 'leftarrow'
                    direction=mod(direction-1,4);
                    waiting=false;
                case 'rightarrow'
                    direction=mod(direction+1,4);
                    waiting=false;
                    
            end
        end
    end
end
