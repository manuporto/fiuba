#!/bin/perl
$CAT_DIR = "catalogos"
$MOV_FILE = "$CAT_DIR/peliculas.mae"

my $spec_id = shift or die "Falta parametro id espectador.\n";
my $input_dir = shift or die "Falta parametro input directory.\n";
my $extra_arg = shift;
if (defined $extra_arg) {
    die "Solo se admiten dos parametros.\n";
}

# TODO check for .dat files in input_dir
if (! -d $input_dir) {
    die "$input_dir no existe como directorio.\n";
}

if (! -d $CAT_DIR) {
    die "$CAT_DIR no existe como directorio.\n";
}

my %movies;
open(my $fh, "<", $MOV_FILE) or die "No se puede abrir $MOV_FILE.\n";
while (my $movie = <$fh>) {
    # id:title:score:length:direc:prod:cat:lactors
    chomp $movie;
    my $movie_data = split(":", $movie);
    my ($cat, $sub_cat) = split("-", $movie_data[6]);
    my $id = $movie_data[0];
    $movies{$id} = $cat;
}
close($fh);

my @files = dir("$input_dir/*.dat");
if (!@files) {
    die "No hay archivos .dat en $input_dir.\n";
}

my %tickets_per_cat;
foreach my $fp (@files) {
    open (my $fh, "<", $fp) or die "..\n";
    while (my $line = <$fh>) {
        # loc:spec_id:movie_id:function:date:tickets
        chomp $line;
        my $line_data = split(":", $line);
        my $curr_spec_id = $line_data[1];
        my $movie_id = $line_data[2];
        my $tickets = $line_data[5];
        if ($curr_spec_id eq $spec_id) {
            my $cat = $movies{$movie_id} or "Indeterminado";
            tickets_per_cat{$cat} += $tickets;
        } 
    }
}
