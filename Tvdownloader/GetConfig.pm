#! /usr/bin/perl
package GetConfig;
require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw (Get_config Get_config_file);
@EXPORT_OK= qw ();

our $g_name;
our $g_season;
our $g_episode;
our $g_format;
our $g_url;
our $g_path;
our $g_enable_proxy;
our $g_proxyserver;
our $g_lastseason;
our $g_lastepisode;

sub Get_config
{
   print "Please input season";
   $g_season=<STDIN>;
   chomp $g_season;
   until ($g_season=~/^[0-9]{1,2}$/)
   {
	      print "Please input season";
        $g_season=<STDIN>;
        chomp $g_season;
   }


   print "Please input episode";
   our $g_episode=<STDIN>;
   chomp $g_episode;
   until ($g_episode=~/^[0-9]{1,2}$/)
   {
        print "Please input episode";
        $g_episode=<STDIN>;
        chomp $g_episode;
   }
 
   print "Please input format";
   our $g_format=<STDIN>;
   chomp $g_format;
   until ($g_format=~/mkv|rmvb|720p|avi|HDTV/)
   {
        print "Please input format";
        $g_format=<STDIN>;
        chomp $g_format;
   }

   print "Please input Websiteurl";
   our $g_url=<STDIN>;
   chomp $g_url;
   until ($g_url=~/^http/)
   {
        print "Please input Websiteurl";
        $g_url=<STDIN>;
        chomp $g_url;
   }


}

sub Get_config_file
{
	
	my @configfile = @_;
	print "GetConfig::Get_config_file configpath @configfile\n";
	open (SOURCE,"@{configfile}") or die;
	
	while (defined ($eachline=<SOURCE>)) 
	{
		if ($eachline =~ /^\[NAME\](.*)$/)
		{
			our $g_name = $1;
			#print $g_name; 
		}
		if ($eachline =~ /^\[SEASON\](.*)$/)
		{
			our $g_season = $1;
			#print $g_season;
		}
		if ($eachline =~ /^\[EPISODE\](.*)$/)
		{
			our $g_episode = $1;
			#print $g_episode;
		}
		if ($eachline =~ /^\[FORMAT\](.*)$/)
		{
			our $g_format = $1;
			#print $g_episode;
		}
		if ($eachline =~ /^\[URL\](.*)$/)
		{
			our $g_url = $1;
			#print $g_url;
		}
		if ($eachline =~ /^\[PATH\](.*)$/)
		{
			our $g_path = $1;
			#print $g_path;
		}
		if ($eachline =~ /^\[PROXY\](.*)$/)
		{
			our $g_enable_proxy = $1;
			#print $g_enable_proxy;
		}		
		if ($eachline =~ /^\[PROXY SERVER\](.*)$/)
		{
			our $g_proxyserver = $1;
			#print $g_proxyserver;
		}
		if ($eachline =~ /^\[LAST SEASON\](.*)$/)
		{
			if (defined $1)
			{
				our $g_lastseason = $1;
			}
			else
			{
				our $g_lastseason = $g_season;
			}
			#print $g_lastseason;
		}
		if ($eachline =~ /^\[LAST EPISODE\](.*)$/)
		{
			if (defined $1)
			{
				our $g_lastepisode = $1;
			}
			else
			{
				our $g_lastepisode = $g_episode;
			}
			#print $g_lastepisode;
		}

	}
	if ($g_season < $g_lastseason)
	{
		$g_season = $g_lastseason;
		$g_episode = $g_lastepisode+1;
	}
	elsif ($g_season == $g_lastseason) 
	{
		if ($g_episode < $g_lastepisode)
		{
			$g_episode = $g_lastepisode+1;
		}
	}
	#print $g_season;
	#print $g_episode;
	if (! -e $g_path)
	{
		mkdir ($g_path,0777) or $!;
	}
	close SOURCE;
	print "GetConfig::Get_config_file Finish read ${g_name} config\n"
}

1;