@echo off
REM ============================================================================
REM  abrir_dashboard.bat
REM  ---------------------------------------------------------------------------
REM  Arranca um pequeno servidor local e abre o painel de monitorizacao no
REM  browser. O painel le os ficheiros que o detetar_anomalias.py grava em
REM  results\ e mostra-os (retrospetiva, predicao e validacao).
REM
REM  COLOCAR: dentro da pasta dashboard/
REM  CORRER : duplo-clique. Para fechar, fecha a janela "Servidor CMMaia".
REM ============================================================================

chcp 65001 >nul

REM Ir para a RAIZ do projeto.
REM %~dp0 é a pasta onde está este .bat: dashboard/
REM .. sobe para a raiz do projeto.
cd /d "%~dp0.."

REM --- Verificar que os ficheiros essenciais estao presentes ------------------

if not exist "dashboard\dashboard.html" (
    echo.
    echo  [ERRO] Nao encontrei dashboard\dashboard.html.
    echo         Confirma que este .bat esta dentro da pasta dashboard/
    echo         e que estas a correr a partir da estrutura correta do projeto.
    echo.
    pause
    exit /b 1
)

if not exist "results" (
    echo.
    echo  [ERRO] Nao encontrei a pasta results.
    echo         O servidor deve arrancar na raiz do projeto.
    echo.
    pause
    exit /b 1
)

REM --- Porta do servidor ------------------------------------------------------

set PORTA=8000

echo ============================================================================
echo   PAINEL DE MONITORIZACAO - CMMaia
echo ============================================================================
echo.
echo   A arrancar o servidor local na porta %PORTA%...
echo   O browser vai abrir automaticamente daqui a uns segundos.
echo.
echo   IMPORTANTE: deixa a janela "Servidor CMMaia" aberta enquanto usas o painel.
echo   Para fechar tudo, fecha essa janela.
echo.

REM --- Arranca o servidor numa janela propria, a partir da raiz do projeto -----

start "Servidor CMMaia" cmd /k "chcp 65001 >nul & echo Servidor a correr em http://localhost:%PORTA%/  --  NAO FECHES esta janela. & echo. & python -m http.server %PORTA%"

REM --- Da tempo ao servidor para ligar, depois abre o dashboard ----------------

timeout /t 2 /nobreak >nul
start "" "http://localhost:%PORTA%/dashboard/dashboard.html"

echo   Pronto. Se o browser nao abrir, vai manualmente a:
echo       http://localhost:%PORTA%/dashboard/dashboard.html
echo.
echo   (Podes fechar esta janela; o servidor continua na outra.)
echo.
timeout /t 4 /nobreak >nul
exit /b 0