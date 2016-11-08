error_code=$(grep ".*")
error_class=$(grep -e "$error_code" "CLASE_DE_ERRORES.dat" > /dev/null && echo $(grep -e "$error_code" "CLASE_DE_ERRORES.dat" | sed -e "s/[^:]*:$error_code:[^:]*:\([^:]*\).*/\1/") || echo "No clasificado")
echo "$error_code - $error_class"
