current_date=$(date +'%Y%m%d')

shopt -s nullglob
for file in "/input/sol_fact_*.txt"; do
  file_date=$(echo $file | cut -d _ -f 3)
  if [ $file_date -gt $current_date ]; then
    cp $file "rechazados/error_fecha_$file"
    continue
  fi 
  while read -r line; do
    id_servicio=$(echo $line | cut -d , -f 1)
    id_cuenta=$(echo $line | cut -d , -f 2) 
    importe=$(echo $line | cut -d , -f 3)
    region=$(echo $line | cut -d , -f 4)
    fecha_vto=$(echo $line | cut -d , -f 5)
    porcentaje=$(grep -E "^$id_servicio,.*,$region,.*" "mae/segba.dat" | cut -d , -f 4)
    if [ -z $porcentaje ]; then
      echo "$line" >> "rechazados/error_$file"
      continue
    fi
    tarif=$(grep -e "$id_cuenta" "mae/tarifa_social.dat" && echo 0 || echo 1)
    imp_total=$importe + $importe*$tarif
    echo "$id_servicio,$id_cuenta,$imp_total,$fecha_vto" >> "resultado/nueva_fact_$file_date" 
  done < "$file"
done
