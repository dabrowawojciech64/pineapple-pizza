function [senses] = whatISee(snake,boardSize,direction)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%y+ - prawo direction=0
%x+ = d� direction=1
%y- =lewo direction=2
%x- = g�ra direction=3
front=0;
left=0;
right=0;
%y+ - prawo direction=0
%x+ = d� direction=1
%y- =lewo direction=2
%x- = g�ra direction=3

switch direction
    case 0
        testsnake=[snake(1,1),snake(1,2)+1];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            front=1;
        end
        testsnake=[snake(1,1)+1,snake(1,2)];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            right=1;
        end
        testsnake=[snake(1,1)-1,snake(1,2)];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            left=1;
        end
    case 1
        testsnake=[snake(1,1)+1,snake(1,2)];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            front=1;
        end
        testsnake=[snake(1,1),snake(1,2)-1];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            right=1;
        end
        testsnake=[snake(1,1),snake(1,2)+1];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            left=1;
        end
    case 2
        testsnake=[snake(1,1),snake(1,2)-1];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            front=1;
        end
        testsnake=[snake(1,1)-1,snake(1,2)];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            right=1;
        end
        testsnake=[snake(1,1)+1,snake(1,2)];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            left=1;
        end
    case 3
        testsnake=[snake(1,1)-1,snake(1,2)];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            front=1;
        end
        testsnake=[snake(1,1),snake(1,2)+1];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            right=1;
        end
        testsnake=[snake(1,1),snake(1,2)-1];
        if any(testsnake==1)||any(testsnake==boardSize)||any(snake(:, 1) == testsnake(1) & snake(:, 2) == testsnake(2))
            left=1;
        end
end

senses=[front,left,right];
end

