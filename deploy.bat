@echo off
REM 构建Hugo站点
echo Building Hugo site...
hugo

REM 检查Hugo构建是否成功
IF %ERRORLEVEL% NEQ 0 (
    echo Hugo build failed. Please check your Hugo configuration.
    pause
    exit /b
)

REM 添加更改到Git
echo Adding changes to Git...
git add *

REM 提交更改
set /p commitMsg="Enter commit message: "
git commit -m "%commitMsg%"

REM 推送到远程仓库
echo Pushing changes to remote repository...
git push

REM 完成
echo Deployment complete!
pause
exit /b