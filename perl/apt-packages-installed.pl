#!/usr/bin/perl

# @author: Johannes (selfnet.de)

## Beispiel: @hosts = qw#user@host1 user@host2 host3# 
@hosts = qw#<liste von rechnernamen/ips>#;
$format = "%-42s".("%-33s" x @hosts)."\n";

%p = ();
foreach (@hosts)
{
        $h = $_;
        $l = qx#/usr/bin/ssh -o ConnectTimeout=200 $_ "dpkg -l"|grep "^ii"|awk '{print \$2 "\t" \$3}'#;
        if(!length($l))
        {
                exit 1;
        }
        foreach(split("\n",$l))
        {
                @a = split("\t",$_);
                $p{$a[0]}{$h} = $a[1];
        }
}

printf "$format\n",'Paket',@hosts;
foreach (sort {$a cmp $b} keys(%p))
{
        $c = $_;
        @v = ();
        foreach (@hosts)
        {
                push(@v,$p{$c}{$_}?$p{$c}{$_}:".");
        }
        printf $format,$_,@v;
}


