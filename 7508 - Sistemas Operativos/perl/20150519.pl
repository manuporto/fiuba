#!/usr/bin/perl

-e "stock/resmas_en_stock" or die "resmas_en_stock no existe.\n";

my $sem_inicio = shift $ARGV or die "Falta semana inicio en args.\n";
my $sem_fin = shift $ARGV or die "Falta semana fin en args.\n";
my $extra_arg = shift $ARGV;
if (defined $extra_arg) {
    die "Solo se admiten dos parametros.\n";
}

if ($sem_inicio > 52 || $sem_inicio < 1 || $sem_fin > 52 || $sem_fin < 1 || $sem_fin < $sem_inicio) {
    die "Semanas de inicio y/o fin incorrectas.\n";
}

# Deberia haberlo hecho con un hash por si el papel pedido no existe
# Asi solo se recorre el archivo una vez.
print "Ingresar tamanio de papel.\n"
my $tam_papel = <STDIN>;
chomp $tam_papel;
my $stock = 0;
open(my $fh, "<", "stock/resmas_en_stock") or die "No se pudo abrir archivo de stock.\n";
while (my $line = <$fh>) {
    chomp $line;
    my($tipo_papel, $cant) = split(";", $line);
    my @info_papel = split("-", $tipo_papel);
    my $tam = $info_papel[0];
    if ($tam_papel eq $tam) {
        $stock += $cant;
    }
}
close($fh);

opendir(my $dir, "consumo_previsto");
@files = readdir($dir);
closedir($dir);

my %consumo;
foreach my $file (@files) {
    if (! $file =~ "resmas_*") {
        continue;
    }
    my ($resm, $sem) = split("_", $file);
    if ($sem < $sem_inicio || $sem > $sem_fin) {
        continue;
    }
    if (open ($fh, "<", "consumo_previsto/$file")) {
        print "No se pudo abrir $file.\n";
        continue;
    }
    while (my $line = <$fh>) {
        chomp $line;
        my ($depto, $p_info, $cant) = split(";", $line);
        my ($tam, $gr) = split("-", $p_info);
        if (exists $consumo{$depto}) {
            $consumo{$depto} += $cant;
        } else {
            $consumo{$depto} = $cant;
        }
    }
    close($fh);
}

open(my $out, ">", "salida");
while (my($k, $v) = each %consumo) {
    print $out "$tam_papel;semana $sem_inicio a $sem_fin;$k;$v\n";
}
close($out);
