#! /usr/bin/perl

package GetAddress;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw (Get_download_address_all Get_download_address);
@EXPORT_OK= qw ();

sub Get_download_address_all 
{
    
    my $path = $GetConfig::g_path;
    my $season = $GetConfig::g_season;
    my $episode = $GetConfig::g_episode;
    my $format = $GetConfig::g_format;
    my $name = $GetConfig::g_name;
    print "Begin Get_download_address_all ${name}\n";
    open (SOURCE,"${path}${name}_source_html") || die ;
    open (DEST,">${path}${name}_address_all") || die ;
    while (defined ($eachline=<SOURCE>))
    {
     chomp $eachline;
     #print @content;
     my @eachlineresult = ($eachline=~/(ed2k:\/\/.*?\/\")/g);
    	if(@eachlineresult>0)   
    	{
    		#print @eachlineresult;
    	    foreach (@eachlineresult)	
    	        {	
    		        $_=~s/"$//;
    		        print DEST $_;
    		        print DEST "\n";
    		      }	     
    	}

    }
    close SOURCE;
    close DEST;
    print "Finish Get_download_address_all ${name}\n";
}

sub Get_download_address
{
    
    my $path = $GetConfig::g_path;
    my $season = $GetConfig::g_season;
    my $episode = $GetConfig::g_episode;
    my $format = $GetConfig::g_format;
    my $name = $GetConfig::g_name;
    print "Begin Get_download_address ${name}\n";
    open (SOURCE,"${path}${name}_address_all") or die;
    open (DEST,">${path}${name}_address") or die;
    @content=<SOURCE>;
    foreach (@content)
    {
      if (/[Ss][0-9][0-9][Ee][0-2][0-9]/)
      {
          /[Ss]([0-9][0-9])[Ee]([0-2][0-9])/;
       #print "\$1 $1\n";
       #print "\$2 $2\n";
       #print "\$3 $3\n";
        if (($1==$season) && ($2>=$episode) && /(?=.*$format)/)
         {
    	      print DEST $_;
         }
        if(($1>$season) && /(?=.*$format)/)
         {
            print DEST $_;
         }
      }
    }
    close SOURCE;
    close DEST;
    print "Finish Get_download_address ${name}\n";
}


1;
