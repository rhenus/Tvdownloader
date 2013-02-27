#! /usr/bin/perl

use Tvdownloader::GetWebSite;
use Tvdownloader::GetAddress;
use Tvdownloader::RunThunder;
use Tvdownloader::GetConfig;
use threads;


my $configpath = get_config_path();
chomp $configpath;

opendir DIR,$configpath;
@dir = readdir DIR;
shift @dir;
shift @dir;
close DIR;
foreach (@dir)
{
	my $thread = threads->create( \&main ); 
	push(@self, $thread);
}

foreach my $thread (@self)
{
    my $thread_result = $thread->join();
    print "thread result $thread_result\n";
}

sub main
{
	GetConfig::Get_config_file($configpath.$_);
	#GetWebSite::Get_website();
	GetAddress::Get_download_address_all();
	GetAddress::Get_download_address();
	RunThunder::Download_thunder($configpath.$_);
	return 0;	
}

sub get_config_path
{
	print "Please input config path\n";
	my $configpath = <STDIN>;
	until ($configpath =~ /^[a-zA-Z]+:\\.*\\$/)
    {
	    print "Please input config path\n";
        $configpath = <STDIN>;
        chomp $configpath;
    }

    return $configpath;
}