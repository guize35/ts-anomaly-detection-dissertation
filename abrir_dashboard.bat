@echo off
REM ============================================================================
REM  abrir_dashboard.bat
REM  ---------------------------------------------------------------------------
REM  Arranca um pequeno servidor local e abre o painel de monitorizacao no
REM  browser. O painel le os ficheiros que o detetar_anomalias.py grava em
REM  results\ e mostra-os (retrospetiva, predicao e validacao).
REM
REM  COLOCAR: na RAIZ do projeto (a pasta que contem 'scripts' e 'results'),
REM           ao lado do ficheiro dashboard.html.
REM  CORRER : duplo-clique.  Para fechar, fecha a janela "Servidor CMMaia".
REM ============================================================================
chcp 65001 >nul
cd /d "%~dp0"

REM --- Verificar que os ficheiros essenciais estao presentes ------------------
if not exist "dashboard.html" (
    echo.
    echo  [ERRO] Nao encontrei o dashboard.html nesta pasta.
    echo         Coloca este .bat na mesma pasta que o dashboard.html
    echo         (a raiz do projeto, ao lado de 'scripts' e 'results'^).
    echo.
    pause
    exit /b 1
)

REM --- Porta do servidor (muda aqui se a 8000 estiver ocupada) ----------------
set PORTA=8000

echo ============================================================================
echo   PAINEL DE MONITORIZACAO - CMMaia
echo ============================================================================
echo.
echo   A arrancar o servidor local na porta %PORTA%...
echo   O browser vai abrir automaticamente daqui a uns segundos.
echo.
echo   IMPORTANTE: deixa a janela "Servidor CMMaia" aberta enquanto usas o
echo   painel. Para fechar tudo, fecha essa janela.
echo.

REM --- Arranca o servidor numa janela propria (fica viva) ---------------------
start "Servidor CMMaia" cmd /k "chcp 65001 >nul & echo Servidor a correr em http://localhost:%PORTA%/  --  NAO FECHES esta janela. & echo. & python -m http.server %PORTA%"

REM --- Da tempo ao servidor para ligar, depois abre o browser -----------------
timeout /t 2 /nobreak >nul
start "" "http://localhost:%PORTA%/dashboard.html"

echo   Pronto. Se o browser nao abrir, vai manualmente a:
echo       http://localhost:%PORTA%/dashboard.html
echo.
echo   (Podes fechar esta janela; o servidor continua na outra.^)
echo.
timeout /t 4 /nobreak >nul
exit /b 0