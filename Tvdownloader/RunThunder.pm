#! /usr/bin/perl

package RunThunder;
#use Win32::OLE;
#require Exporter;
@ISA = qw (Exporter);
@EXPORT = qw (Download_thunder);
@EXPORT_OK = qw ();

sub Download_thunder
{
	eval 'use Win32::OLE';
	my $path = $GetConfig::g_path;
	my $name = $GetConfig::g_name;
	my $season_downloaded ;
	my $episode_downloaded ;
	my @configfile = @_;
	print "RunThunder::Download_thunder Begin Download_thunder ${name}\n";
	open (SOURCE,"${path}${name}_address") or die;
	
	while (defined ($eachline=<SOURCE>))
		{
			chomp $eachline;
			$eachline =~ /[Ss]([0-3][0-9])[Ee]([0-2][0-9])/;
			$season_downloaded = $1;
			$episode_downloaded = $2;
			#print "season_downloaded $season_downloaded\n";
			#print "episode_downloaded $episode_downloaded\n";
			#print "download_url $eachline\n";
			#my $obj=Win32::OLE->new('ThunderAgent.Agent.1') or die;
			#$obj->AddTask($eachline,$name.$season_downloaded.$episode_downloaded,$path,,,1,0,5) ;
			#$obj->CommitTasks2(1);
			print "RunThunder::Download_thunder configfile @{configfile}\n";
			open (CONFIG,"@{configfile}") or die;
			open (NEWCONFIG,">@{configfile}1") or die;
			while (defined ($configeachline=<CONFIG>)) 
			{
				if ($configeachline =~ /^\[LAST SEASON\]/)
				{
					$configeachline =~ s/\].*$/\]$season_downloaded/;
				}
				if ($configeachline =~ /^\[LAST EPISODE\]/)
				{
					$configeachline =~ s/\].*$/\]$episode_downloaded/;
				}
				#print "configeachline $configeachline\n";
				print NEWCONFIG $configeachline;
			}
			close CONFIG;
			close NEWCONFIG;
			#print "${configpath}config\n";
			unlink "@{configfile}";
			print "RunThunder::Download_thunder del old config $!\n";
			#print "${configpath}${name}config1\n";
			rename "@{configfile}1","@{configfile}";
			print "RunThunder::Download_thunder rename config $!\n";
		}
	close SOURCE;	
		
	print "RunThunder::Download_thunder Finish Download_thunder ${name}\n";
}

1;