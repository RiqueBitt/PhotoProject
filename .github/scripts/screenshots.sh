#!/usr/bin/env bash
# PhotoProject: abre o app de verdade e captura as telas principais
# usando uma imagem de exemplo gerada na hora (pôr do sol com montanhas).
source "$(dirname "$0")/screenshots-common.sh"

SAMPLE="$OUT/../exemplo-por-do-sol.png"
convert -size 1600x1000 gradient:'#1E1B4B'-'#F97316' \
  \( -size 1600x1000 xc:none -fill '#FDE68A' -draw 'circle 1050,560 1050,450' -blur 0x6 \) -composite \
  -fill '#3B0764' -draw 'polygon 0,1000 0,700 260,540 520,720 760,560 1040,760 1300,600 1600,740 1600,1000' \
  -fill '#1E1B4B' -draw 'polygon 0,1000 0,820 300,700 620,860 900,740 1200,880 1600,800 1600,1000' \
  "$SAMPLE"

"$APP" > "$OUT/app.log" 2>&1 &
APP_PID=$!
sleep 35
maximize "PhotoProject"
shot inicio 3

# Novo documento (diálogo de predefinições)
key ctrl+n; shot novo-documento 3
key Escape; sleep 1

# Abre a foto de exemplo pelo diálogo Abrir
key ctrl+o; sleep 3
typ "$SAMPLE"; key Return
shot foto-aberta 6
key ctrl+0; sleep 1

# Ajustes
key ctrl+m; shot curvas 3
key Escape; sleep 1
key ctrl+l; shot niveis 3
key Escape; sleep 1
key ctrl+u; shot matiz-saturacao 3
key Escape; sleep 1

# Menu Filtro
click 417 36; shot menu-filtro 2
key Escape; sleep 1

# Nova camada + pincel
key ctrl+shift+n; sleep 2; key Return; sleep 1
key x; key b
drag 300 300 700 380; drag 320 420 760 460; drag 340 520 640 500
shot pincel-camadas 2

# Seleção retangular
key m; drag 900 250 1250 520; shot selecao 2
key ctrl+d; sleep 1

# Texto
key t; click 500 760; sleep 1; typ "Project Club"; shot texto 2
key ctrl+Return; key Escape; sleep 1

# Menus Camada e Imagem
click 237 36; shot menu-camada 2
key Escape; sleep 1
key alt+i; shot menu-imagem 2
key Escape; sleep 1

# Menu Editar
click 113 36; shot menu-editar 2
key Escape
finish
