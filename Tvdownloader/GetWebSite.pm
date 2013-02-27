#! /usr/bin/perl
package GetWebSite;

require Exporter;
@ISA = qw(Exporter);
@EXPORT = qw (Get_website);
@EXPORT_OK= qw ();
use LWP::Simple;
use LWP::UserAgent;
use Encode;


sub Get_website 
{
	require Encode;
	my $path = $GetConfig::g_path;
	my $enable_proxy = $GetConfig::g_enable_proxy;
	my $proxyserver = $GetConfig::g_proxyserver;
	my $url = $GetConfig::g_url;
	my $name = $GetConfig::g_name;
	print "Begin get ${name} website\n";
	open (DEST,">${path}${name}_source_html") or die;
	if ( $enable_proxy eq "y")
	{
		print "Begin proxy get ${name} website\n"; 
		$agent = LWP::UserAgent->new();
		$proxy = $agent->proxy(http=>$proxyserver);
		$content = $agent->get($url);
		#print $content->content;
		print DEST Encode::encode("utf-8",Encode::decode("utf-8",$content->content));
	}
	else
	{
	
		getstore($url,"${path}${name}_raw_html");
		open (SOURCE,"${path}${name}_raw_html") or die;
		while (defined ($eachline=<SOURCE>))
		{
	    	print DEST Encode::encode("utf-8",Encode::decode("utf-8",$eachline));
		}
		close SOURCE;
	}
	
	#close SOURCE;
	close DEST;
	print "Finish get ${name} website\n";
}
1;
