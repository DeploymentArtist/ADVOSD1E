New-Item -Path D:\MigData -ItemType Directory
New-Item -Path D:\Logs -ItemType Directory
New-Item -Path D:\SCCM_Sources -ItemType Directory
New-Item -Path D:\SCCM_Sources\OSD -ItemType Directory
New-Item -Path D:\SCCM_Sources\OSD\Boot -ItemType Directory
New-Item -Path D:\SCCM_Sources\OSD\DriverPackages -ItemType Directory
New-Item -Path D:\SCCM_Sources\OSD\DriverSources -ItemType Directory
New-Item -Path D:\SCCM_Sources\OSD\MDT -ItemType Directory
New-Item -Path D:\SCCM_Sources\OSD\OS -ItemType Directory
New-Item -Path D:\SCCM_Sources\OSD\Settings -ItemType Directory
New-Item -Path D:\SCCM_Sources\Software -ItemType Directory
New-Item -Path D:\SCCM_Sources\Software\Adobe -ItemType Directory
New-Item -Path D:\SCCM_Sources\Software\Microsoft -ItemType Directory

net share 'Logs$=D:\Logs' '/grant:EVERYONE,change'
icacls D:\Logs /grant '"VIAMONSTRA\CM_NAA":(OI)(CI)(M)'
net share 'SCCM_Sources$=D:\SCCM_Sources' '/grant:EVERYONE,full'