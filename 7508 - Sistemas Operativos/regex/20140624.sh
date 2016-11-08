#!/usr/bin/bash
dni=$(grep ".*")
exp=$(grep -E "[^;]*;[^;]*;$dni;[^;];ACTIVO;.*" "Cuentas.Master")
echo $exp | sed -e "s@\([^;]*\);[^;];$dni;[^;]*;ACTIVO;\([0-9]\{3\}\)/\([0-9]\{8\}\);\([^;]*\)@\1 \2 \3 \4@"
