#!/usr/bin/perl

my $output_file = shift $ARGV or die "Falta archivo de salida.\n";
if (-e $output_file) {
    die "Archivo de salida ya existe.\n";
}

if (! -e "cultivos") {
    die "Archivo de cultivos no existe.\n";
}
my $zone_code = <STDIN>;
my $zone_name;
my $found = 0;
open(my $fh, "<", "zonas.tab") or die "Archivo de zonas no existe.\n";
while (my $line = <$fh>) {
    chomp $line;
    my $fields = split(";", $line);
    if ($fields[0] eq $zone_code) {
        $found = 1;
        $zone_name = $fields[1];
        break;
    }
}
close($fh);

if ($found == 0) {
    die "Codigo de zona inexistente.\n";
}

my %cultivado;
open($fh, "<", "cultivos");
while (my $line = <$fh>) {
    # Código de zona:Código de Establecimiento:Cultivo:Superficie cultivada
    # :Rinde Esperado:Superficie cosechada:Rinde Obtenido
    chomp $line;
    my $fields = split(":", $line);
    if ($fields[0] ne $zone_code) {
        continue;
    }
    $cultivado{$fields[2]} += ($fields[6] - $fields[4]); 
}
close($fh);


