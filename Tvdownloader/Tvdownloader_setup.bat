
if exist c:\strawberry\perl\lib\Tvdownloader\ (
	copy *.pm "c:\strawberry\perl\lib\Tvdownloader\"
) else ( 
	md c:\strawberry\perl\lib\Tvdownloader\ 
	copy *.pm c:\strawberry\perl\lib\Tvdownloader\ 
)

if exist c:\config\ (
	copy *.conf c:\config\
) else ( 
	md c:\config\
	copy *.conf c:\config\ 
)