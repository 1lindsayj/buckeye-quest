clc
clear
game_scene = simpleGameEngine('retro_pack.png',16,16,4,[245,245,245]);
[BL_menu,  BL_LS, ML_lvl1, BL_lvl1]= initlization();

% - npc code
questionBank = {
   'What does the “D” in DRPIE stand for?', 'Define';
   'What does MATLAB stand for?', 'Matrix Laboratory';
   'How do you clear the command window in MATLAB?', 'clc';
   'How do you create a vector containing the numbers 1 to 5, with a step size of 2?', '[1:2:5]';
   'How do you clear all variables from the workspace in MATLAB?', 'clear';
   'How do you plot a simple line graph in MATLAB?', 'plot()';
   'What is the correct term for raw facts and figures?', 'Data';
   'What does the “P” in DRPIE stand for?', 'Plan'
};

% MENU
drawScene(game_scene,BL_menu)
while true
[r,c,b] = getMouseInput(game_scene);
if r == 7 && c == 9 || c ==10 || c==11|| c==12 || c==13 && b ==1
drawScene(game_scene,BL_LS)
elseif  r ~= 7 && c ~= 9 || c ~=10 || c~=11|| c~=12 || c~=13 && b ==1
   fprintf('Please Press Start')
end
% LEVEL SELECT
[r,c,b] = getMouseInput(game_scene);
if r == 1 && c==13||c==14||c==15||c==16||c==17||c==18||c==19||c==20||c==21 && b==1
   fprintf(['A - Move Left \n' ...
       'D - Move Right \n' ...
       'W - Jump Right \n' ...
       'S - Jump Left \n' ...
       'SPACEBAR - Interact with NPC \n' ...
       'ENTER - Interact with door'])
elseif r == 8 && c == 11 && b ==1
character = 26; %controllable character
%Start location:
x = 7;
y = 16;
ML_lvl1(y,x) = character;
drawScene(game_scene, BL_lvl1, ML_lvl1)
while 1   
  key = getKeyboardInput(game_scene);
   title(key); %Prints the value of 'key' above the image created by the sprites
   if y<17 && ML_lvl1(y+1,x)<2
    ML_lvl1(y,x) = 1;
       ML_lvl1(y+1,x) = character;
        y = y+1;
   drawScene(game_scene,ML_lvl1,BL_lvl1)        
   elseif strcmp(key, 'a') && x >1 && ML_lvl1(y,x-1)<2
       ML_lvl1(y,x) = 1;
       ML_lvl1(y,x-1) = character;
       x = x-1;
       drawScene(game_scene,ML_lvl1,BL_lvl1);
   elseif strcmp(key, 'd') && x <21 && ML_lvl1(y,x+1)<2
       ML_lvl1(y,x) = 1;
       ML_lvl1(y,x+1) = character;
       x = x+1;
       drawScene(game_scene,ML_lvl1, BL_lvl1);
   elseif strcmp(key, 'w') && x<20 & y>1 && ML_lvl1(y-2,x+2)<2 && ML_lvl1(y+1,x)>2
       ML_lvl1(y,x) = 1;
       ML_lvl1(y-2,x+2) = character;
       x = x+2;
       y = y-2;
      drawScene(game_scene,ML_lvl1,BL_lvl1)
   elseif strcmp(key, 's') && x>2 & y>1 && ML_lvl1(y-2,x-2)<2 && ML_lvl1(y+1,x)>2
       ML_lvl1(y,x) = 1;
       ML_lvl1(y-2,x-2) = character;
       x = x-2;
       y = y-2;
       drawScene(game_scene,ML_lvl1,BL_lvl1);
   elseif strcmp(key, 'space') & (x == 16 && y == 14)
  runNPCinteraction(questionBank, x, y, ML_lvl1, game_scene);
   else
       drawScene(game_scene,ML_lvl1,BL_lvl1);
   end
end
end
end

% - npc location
npc = 243 %non-controlled playable character
%located:
npcX = 10
npcY = 16
ML_lvl1(npcY, npcX) = npc;
% - initialize/define
toolSprite = 770; %subject to change w/ new sprite sheet
toolGiven = 0;
% - full interaction function(s)
function runNPCinteraction(questionBank, x, y, ML_lvl1, game_scene)
questionIndex = randi(size(questionBank,1)); %random question index
question = questionBank{questionIndex,1}; %seperating question/n
correctAnswer = questionBank{questionIndex,2}; %from answers
clc
fprintf('NPC: Hello! Answer this question to receive a tool to help you complete this level. ');
fprintf('Question: %s', question)
userAnswer = input(' Your answer is: ', 's');
if strcmp(strtrim(userAnswer), correctAnswer)
   fprintf('You are correct! Here is the tool. Good luck :)')
   ML_lvl1(y,x) = 770; %subject to change
   toolGiven = 1;

else
   fprintf('That is incorrect. The correct answer was: %s', correctAnswer)
   fprintf('. Please try again!')
   toolGiven = 0;
end
pause(3);
drawScene(game_scene,ML_lvl1)
end

% - bridge creation
while 1
    if toolGiven == 1
      ML_lvl1 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1; %middle sprite layer
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,177,177,177,177,177,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,295,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,7,7,7,7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,491,492,493,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,243,523,524,525,1;
 1,1,1,1,1,1,1,1,1,820,1,1,1,1,1,7,7,7,7,7,7;
 1,1,1,1,1,1,177,177,1,243,1,1,1,7,7,7,7,7,7,7,7;
 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7;]  
    else 
       ML_lvl1 = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1; %middle sprite layer
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,295,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,7,7,7,7,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,491,492,493,1;
 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,243,523,524,525,1;
 1,1,1,1,1,1,1,1,1,820,1,1,1,1,1,7,7,7,7,7,7;
 1,1,1,1,1,1,177,177,1,243,1,1,1,7,7,7,7,7,7,7,7;
 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7;]
    end
end
