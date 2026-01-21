### Requirements
I want to make it end to end work in my local Claude code cli for all my projects. First, I setup projects tasks and working branch then I will let Claude code ask me as many as possible questions before the coding. Than start the coding,  after coding done and ask me to do some testing then create the PR, before the PR Claude code needs to do code quality checks and make the code clear and ready for review then create the PR . Waiting for 10 to 15 minutes to create screenshots for the code review feedbacks and make the changes if the code review comments makes senses. If not , please do not make the change, than commit the change after fixing all the comments at one time.  Then comments the PR with @devai review to get reviews again and repeat the process to get all changes looking good. 

The task has a title with "radr://123456 create a tools to clean all the cache files to free the Mac os disk space". So it will start with following template to create a task section

### "radr://123456 create a tools to clean all the cache files to free the Mac os disk space"
So the working branch should always git checkout the main and pull the latest code from main. Then git checkout -b radar_123456 to have a working branch. 

In my Mac os, I already install gh command, Claude code cli can use gh pr create --base main -f  to create PR. The PR just need to have --title with the task title like "radr://123456 create a tools to clean all the cache files to free the Mac os disk space" --summary list updated files. 

In each of project, we will have a .claude folder. all claude generated document we need to put in this folder. 
For claude code to create screenshot of code review, we need to create folder under .claude named codereview and put all the screenshot in this folder. After fixed all the code review comments, we need to delete all the screenshot. How can we automate the whole process?

we need to create a claude code automation workflow for it. 

