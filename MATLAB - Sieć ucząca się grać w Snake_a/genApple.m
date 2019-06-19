function [apple] = genApple(snake,n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
notgood=true;
while(notgood)
    apple=randi([2,n-1],1,2);
    for i=1:size(snake,1)
       if ( all (apple == snake(i,:) ) )
           notgood=true;
           break
       end
       notgood=false;
    end
end
end

