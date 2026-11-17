@echo off
setlocal enabledelayedexpansion

cd /d "E:\source\VS Code\colibri"
set "MODELS_DIR=E:\colibri-models"

if not exist "%MODELS_DIR%" mkdir "%MODELS_DIR%"

REM All compatible ("good") models from setup --list (excluding qwen36-35b if already moved)
set "MODELS=qwen3-coder-30b qwen-image-2.1 deepseek-v4-flash-reap deepseek-v4-flash mimo-v2.6-flash qwen38-flash-next glm-5.3 glm-5.2 mimo-v2.6-pro kimi-k3"

for %%M in (%MODELS%) do (
    echo ========================================================================
    echo Downloading %%M into %MODELS_DIR%...
    echo ========================================================================
    py -3 c\coli setup --model %%M --dir "%MODELS_DIR%" --backend cuda --no-start
    if errorlevel 1 (
        echo [WARNING] %%M exited with an error. Re-run this script anytime to resume.
    )
)

echo.
echo All downloads finished!
pause
