FROM rocklobster/chocolatey:0.10.5

LABEL maintainer="tom@thingamajig.net"
LABEL description="Windows Server Core running PoshBot"

#ENV SLACK_TOKEN
ENV BOT_NAME poshbot
ENV BOT_LOGLEVEL Verbose
#ENV BOT_ADMINS

WORKDIR c:\\bot

RUN powershell -executionpolicy bypass -command \
	Install-PackageProvider NuGet -Force ;\
	Import-PackageProvider NuGet -Force ;\
	Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

RUN powershell -executionpolicy bypass -command \
	Install-Module -Name PoshBot ;\
	Import-Module PoshBot

COPY setupBot.ps1 .

#CMD [ "powershell", ". c:\bot\setupBot.ps1" ]	
CMD powershell . c:\bot\setupBot.ps1

