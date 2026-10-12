#!/usr/bin/env bash
# PhotoProject: abre o app de verdade e captura as telas principais.
source "$(dirname "$0")/screenshots-common.sh"
"$APP" > "$OUT/app.log" 2>&1 &
APP_PID=$!
sleep 35
maximize "PhotoProject"
shot inicio 3
key ctrl+n; shot novo-documento 3
key Return; shot tela-em-branco 4
key b; drag 500 400 900 500; drag 520 560 1000 620; shot pincel 2
key ctrl+shift+n; shot nova-camada 3
key Return; sleep 1
key m; drag 600 300 900 600; shot selecao 2
key ctrl+d; key g; click 700 450; shot preenchimento 2
key t; click 650 700; typ "Project Club"; key Escape; shot texto 2
key ctrl+m; shot curvas 3
key Escape; key ctrl+l; shot niveis 3
key Escape; key ctrl+u; shot matiz-saturacao 3
key Escape; key ctrl+comma; shot preferencias 3
key Escape; key alt+f; shot menu-arquivo 2
key Escape; key alt+i; shot menu-imagem 2
key Escape
finish
