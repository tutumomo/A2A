@echo off
echo ----------------------------------------
echo [INFO] �}�l�B�z Git �M�סG%cd%
echo ----------------------------------------

REM �T�O upstream remote ���T�]�n�]���|�Ψ� push�^
git remote | findstr "upstream" > nul
IF ERRORLEVEL 1 (
    echo [INFO] �[�J upstream �ӷ�...
    git remote add upstream https://github.com/google/A2A.git
) ELSE (
    echo [INFO] upstream �w�s�b�A���L�[�J�C
)

REM �[�j���b�G�]�������\ push �� upstream
git remote set-url --push upstream no_push

REM �ԭ�l�@�̧�s�쥻�a
echo [INFO] Fetch + Pull upstream/main ...
git fetch upstream
git pull upstream main

REM ��ܪ��A
echo [INFO] ��e Git ���A�p�U�G
git status

REM �O�d�T�{�ʧ@�]�i�����^
pause

REM ����ۤv���ܧ�ñ��� fork�]origin�^
echo [INFO] �}�l commit �� push �� origin ...
git add .
git commit -m "��s"
git push origin main

echo ----------------------------------------
echo [����] �P upstream �P�B�A�ñ��e�� origin�C
echo ----------------------------------------
pause
