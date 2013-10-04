#!/bin/sh

#
# Rasticrac v3.1a5 (oct 2013)
# By tjglass and DblD [AppAddict]
#
# Rapid Advanced Secure Thorough Intelligent Gaulish Nuclear Acclaimed Cracker
#
#
# The truth is I never left you. I kept my promise.
#
# This is an improved version of rasticrac that works 3x faster! (Thanks to dumpdecrypted by Stefan Esser)
#
# This script will also include an upload and submit feature!
#
# Original Creator Home: https://twitter.com/iRastignac
#
#

if [ $UID -ne 0 ]; then
   echo "Please run as root!"
   exit 1
fi

# ======
# Please, customize the script first !
# Choices are:

# - Default language (US: English).
# - Languages Have Been Removed They Will Be Added At A Later Date
 RClang="US"

# - User credentials for uploading to MEGA
# - N/A
#megauser=""
#megapass=""

# - Default CrackerName (or "Anonymous").
RCcracker="Anonymous"

# - If you Crack For AppAddict Enter "aa" (No Caps, No quotes - don't delete the ones below, don't and new ones)
# - If you Crack For A Other Site (e.g. iPhoneCake) Enter "other" (No Caps, No quotes - don't delete the ones below, don't and new ones)
#Crcommunity=""

# - Should "extra details" appear in Ipa name (ie: "iPad / 3GS / etc") ? (You can hate them)
RCextras="YES"

# - Display graphical progress bars ? (based on number and/or size of apps) ("by size" is slower)
RCbarNum="YES"
RCbarSize="YES"

# - Should display be verbose ? (verbose is slower and messier)
RCverbose="NO"

# - Should script talk to you ? (it only speaks english, only with iOS4+, only with "speak" tool from Cydia)
RCspeak="YES"

# - Should artist's name be used in filename ?
RCartistfrommeta="YES"

# - Should menu display 'real name' of apps ? (slower, slower, and strange sort order)
RCrealnamemenu="NO"

# - Default compression level is blank (aka "-6"), and is the best speed/size ratio.
# - Recommended. Upload/download/storage will be good.
RCcompression=""
# - Maximum compression ("-9") (also "-8" or "-7") is very very slow, but size is the best.
# - If your iDevice is fast, if you're not in a hurry, if size matters. Best upload/download/storage.
#RCcompression="-9"
# - Minimum compression ("-2") (also "-3" to "-5") is way faster, but size is way worse.
# - Upload/download/storage will be worse. (CrackTM and Clutch and newest Crackulous use "-2").
# - With "-2", RC will be as fast as the others.
#RCcompression="-2"
# - Don't use "-1" (sloppy) or "-0" (store), as size will be horrible, and all will suffer. Avoid.

# - Should I generate fake MetaData or not ?
#   (Some people hate them, some love them, some protections check them, you should really keep them)
RCmetadata="YES"

# - Should I try LamestPatchest on the executable ?
#   (It won't work 100%, but sometimes it really helps) (and now it's very very fast) (you should keep it)
RClamestpatchest="YES"

# - What menu dots do you prefer ?
 RCdots=".............................."
#RCdots="------------------------------"
#RCdots="			       "
#RCdots="______________________________"

# Progress bar display
RCxxx="====="
RCsss="-----"

# Low-end iDevice (with low memory) (addind swap also will help)
RClowend="NO"

# DEBUG ONLY: - Force the "this script is running inside a GUI" check ?
RCinaGUI="NEVER"
# DEBUG ONLY: - Check only (all tested but Ipa not created)
RCcheck="NEVER"

# Thanks you for testing.
# ======


# Checking for Mega LOGIN
# if [ -e "/var/root/.megacmd.json" ];
# then
#   echo "Login File Found"
# else
#   echo "Mega.co.nz Login file not created"
#   echo "Do you want to upload to MEGA? Y/N"
#   read megayn
#   if [ $megayn = "y" ];
#   then
#		 echo "Creating Login File..."
#		# - Creating File
#		 echo "{" > "/var/root/.megacmd.json"
#		 echo "User : $megauser ," >> "/var/root/.megacmd.json"
#		 echo "Password : $megapass ," >> "/var/root/.megacmd.json"
#		 echo "DownloadWorkers : 4," >> "/var/root/.megacmd.json"
#		 echo "UploadWorkers : 4," >> "/var/root/.megacmd.json"
#		 echo "SkipSameSize : true," >> "/var/root/.megacmd.json"
#		 echo "Verbose : 1" >> "/var/root/.megacmd.json"
#		 echo "}" >> "/var/root/.megacmd.json"
#		 echo "Done!"
#   else
#		 echo "MEGA uploading #disabled!"
#   fi
# fi

# ======
function SelectLanguage
{
	MsgAltMeth="Using alternative dumping method"
	MsgAnaAppl="Analyzing application"
	MsgAppLoca="Locating"
	MsgBadChoi="Bad choice"
	MsgBldMenu="Building menu..."
	MsgBrzMode="Berzerk mode: cracking ALL"
	MsgCntFind="Cannot find"
	MsgCopExec="and copying executable"
	MsgCreDire="Creating directories"
	MsgDmpUncr="Dumping unencrypted data from application"
	MsgIpaInco="Incomplete .ipa"
	MsgDskFull="Disk full"
	MsgEraMemo="Erasing memory file"
	MsgInsCydi="Install from Cydia"
	MsgIpaDone="Done as"
	MsgMnuEmpt="empty"
	MsgMarDone="Marking all apps done"
	MsgPatCryp="Locating and patching CryptID"
	MsgRemTemp="Removing temporary files"
	MsgRepData="and replacing encrypted data"
	MsgSizUnit="B"
	MsgUnaLoca="Unable to locate"
	MsgVrfDump="Verifying dump"
	MsgWrgChoi="Wrong choice"
	MsgWarning="Warning"
	MsgWrnMeta="iTunesMetadata format changed"
	MsgYouChoi="Your choices"
	MsgZipStep="Compressing the .ipa (step"
	MsgComBoth="Combining both parts into a fat binary"
	MsgSgnAppl="Signing the application"
	MsgCopArtw="Copying Artwork"
	MsgFakMeta="and faking MetaData"
	MsgNotMeta="and no MetaData"
	MsgFoundIt="Found"
	MsgWasAskd="Asked"
	MsgErrrors="Errors"
	MsgBrzNoth="nothing"
	MsgMrkDone="Mark all done		  "
	MskZroDone="Reset done list		  "
}


# ======
function UnicodeToHuman
{
# Convert from unicode to human, and remove unwanted chars
human=$(echo -n "$unicode" | sed -e "s: :_:g" | od -c -A n -v --width=999 | sed \
	-e 's:+:Plus:g' \
	-e 's:302.240:_:g' \
	-e 's:302.251:_:g' \
	-e 's:302.256:_:g' \
	-e 's:302.260:Degree:g' \
	-e "s:302.264:':g" \
	-e 's:303.201:A:g' \
	-e 's:303.207:C:g' \
	-e 's:303.211:E:g' \
	-e 's:303.216:I:g' \
	-e 's:303.224:O:g' \
	-e 's:303.234:U:g' \
	-e 's:303.237:B:g' \
	-e 's:303.240:a:g' \
	-e 's:303.241:a:g' \
	-e 's:303.242:a:g' \
	-e 's:303.245:a:g' \
	-e 's:303.247:c:g' \
	-e 's:303.250:e:g' \
	-e 's:303.251:e:g' \
	-e 's:303.252:e:g' \
	-e 's:303.253:e:g' \
	-e 's:303.255:i:g' \
	-e 's:303.256:i:g' \
	-e 's:303.257:i:g' \
	-e 's:303.263:o:g' \
	-e 's:303.264:o:g' \
	-e 's:303.266:o:g' \
	-e 's:303.270:o:g' \
	-e 's:303.271:u:g' \
	-e 's:303.273:u:g' \
	-e 's:303.274:u:g' \
	-e 's:304.237:g:g' \
	-e 's:304.261:i:g' \
	-e 's:305.223:oe:g' \
	-e 's:312.236:k:g' \
	-e 's:316.251:Omega:g' \
	-e 's:342.200.223:-:g' \
	-e 's:342.200.224:-:g' \
	-e "s:342.200.230:':g" \
	-e "s:342.200.231:':g" \
	-e 's:342.200.242:-:g' \
	-e 's:342.202.254:EUR:g' \
	-e 's:342.204.242:_:g' \
	-e 's:342.210.236:Infinity:g' \
	-e 's:342.213.205:.:g' \
	-e 's:342.226.272:_:g' \
	-e 's:342.227.217:-:g' \
	-e 's:342.230.205:_:g' \
	-e 's:342.231.253:_:g' \
	-e 's:342.235.222:_:g' \
	-e 's:347.246.205:_:g' \
	| tr -cd "[:alnum:][_'.][-]" | sed -e "s:_: :g" | sed -e "s:  : :g" )
# Todo: future enhancements
# Help wanted for unknown or other unicodes
}


# ======
function DisplayBars
{
ProgressPct=""
if [ $RCbarNum = "YES" ]; then
	ProgressXXX=$(( $BarCols * $ProgressDone / $ProgressTarget ))
	ProgressSSS=$(( $BarCols - $ProgressXXX ))
	ProgressPct=$(( 100 * $ProgressDone / $ProgressTarget ))
	echo "[${escGreen}${RCxxx:0:$ProgressXXX}${escBlue}${RCsss:0:$ProgressSSS}${escReset}] $ProgressPct%"
fi
if [ $RCbarSize = "YES" ]; then
	ProgressXXX=$(( $BarCols * $ProgressDoneSize / $ProgressTargetSize ))
	ProgressSSS=$(( $BarCols - $ProgressXXX ))
	ProgressPct=$(( 100 * $ProgressDoneSize / $ProgressTargetSize ))
	echo "[${escCyan}${RCxxx:0:$ProgressXXX}${escBlue}${RCsss:0:$ProgressSSS}${escReset}] $ProgressPct%"
fi

if [ ! -z "$ProgressPct" -a $RCspeak = "YES" ]; then
	su mobile -c "speak $ProgressPct %" &
fi
}


# ======
# Begin LowEnd Function
function LowEndFunction
{
	if [ $RClowend = "YES" ]; then
		#echo "${Meter35}Trying to free some memory..."
		p="/var/mobile/Library/SBSettings/Commands/com.sbsettings.freemem"
		if [ -e "$p" ]; then
			$p 2>/dev/null
		else
			echo "${Meter35}${escRed}SbSettings not found !${escReset}"
		fi
		sleep 1
	fi
}


# ======
# Begin Crack Function
function CrackFunction
{
	# Remove ASLR - Experiment
	# python change_mach_o_flags.py --no-pie "$AppPath/$AppName/$AppExec"
	
	# Cracking App Executable
	# Patching CryptID 01 -> 00
	cp "/var/root/dumpdecrypted.dylib" "/$WorkDir"
	cd "/$WorkDir"
	echo "Cracking the binary..."
DYLD_INSERT_LIBRARIES=dumpdecrypted.dylib "$AppPath/$AppName/$AppExec" mach-o decryption dumper
	
	# Replacing executable's crypted data with dumped clear data
	if [ $RCverbose = "YES" ]; then
		echo "${Meter54}$MsgRepData"
	fi
mv "$WorkDir/$AppExec.decrypted" "$WorkDir/$AppName/$AppExec"
}


# ======
# Begin Core Function
function CoreFunction
{
AppInput=$1
CrackerName=$2
CreditFile=$3
#Crcommunity=$4

if [ ! "$CrackerName" ]; then
	CrackerName="$RCcracker"
fi

if [ ! "$CreditFile" ]; then
	CreditFile="$CrackerName"
fi

#if [ ! "$CrCommunity" ]; then
#	Crcommunity="$Crcommunity"
#fi
# Script has app's full directory path as input (ie: called from GUI)
if [ -d "$AppInput" ]; then
	tempLoc=$AppInput
else
	# Script has app's name as input
	echo "$MsgAppLoca '$AppInput'"
	# Escape the "*" as ".*"
	AppGrep=$(echo "/$AppInput\.app" | sed "s:\*:\.\*:g")
	if [ -e /tmp/lsd.tmp ]; then
		tempLoc=$(grep -i "$AppGrep" /tmp/lsd.tmp)
	else
		tempLoc=""
	fi
	if [ -z "$tempLoc" ]; then
		echo "$MsgUnaLoca '$AppInput'"
		rm -f /tmp/lsd.tmp
		return 1
	fi
	AppCount=$(echo "$tempLoc" | wc -l)
	if [ $AppCount -gt 1 ]; then
		echo "$MsgFoundIt $AppCount installation directories:"
		echo "$tempLoc"
		rm -f /tmp/lsd.tmp
		return 1
	fi
fi

# The app has been found
MenuFound=$(($MenuFound + 1))
AppPath=$(dirname "$tempLoc")
AppName=$(basename "$tempLoc")
echo -n "${Meter4}${escCyan}$MsgFoundIt ${escReset}'$(echo $AppName | sed "s:\\.app::")': "

if [ ! -d "$AppPath" ]; then
	echo "$MsgUnaLoca original installation directory"
	return 1
fi
if [ ! -d "$AppPath/$AppName" ]; then
	echo "$MsgUnaLoca .app directory"
	return 1
fi
AppExec=$(plutil -key CFBundleExecutable "$tempLoc/Info.plist" 2> /dev/null)
if [ ! -e "$AppPath/$AppName/$AppExec" ]; then
	echo "$MsgUnaLoca executable"
	return 1
fi
# Get the name from MetaData
AppDisplayName=$(plutil -key itemName "$AppPath/iTunesMetadata.plist" 2> /dev/null)
# No alphanum characters at all ?
AppDisplayNameAlpha=$(echo -n "$AppDisplayName" | tr -cd "[:alnum:]")
if [ "$AppDisplayNameAlpha" = "" ]; then
	#echo "${Meter5}$MsgWarning: non-alpha name !"
	AppDisplayName=""
fi
# Get the name from InfoPlist or from executable name
if [ "$AppDisplayName" = "" ]; then
	AppDisplayName=$(plutil -key CFBundleDisplayName "$tempLoc/Info.plist" 2> /dev/null)
	AppDisplayNameAlpha=$(echo -n "$AppDisplayName" | tr -cd "[:alnum:]")
	if [ "$AppDisplayNameAlpha" = "" ]; then
		AppDisplayName=$(plutil -key CFBundleName "$tempLoc/Info.plist" 2> /dev/null)
		AppDisplayNameAlpha=$(echo -n "$AppDisplayName" | tr -cd "[:alnum:]")
		if [ "$AppDisplayNameAlpha" = "" ]; then
			AppDisplayName=$AppExec
			#AppDisplayNameAlpha=$(echo -n "$AppDisplayName" | tr -cd "[:alnum:]")
			#if [ "$AppDisplayNameAlpha" = "" ]; then
			#	echo "${Meter6}$MsgWarning: too exotic name !"
			#fi
		fi
	fi
fi

# Convert AppName from unicode to human
unicode=$AppDisplayName
UnicodeToHuman
AppDisplayName=$human

# Get the artist name from MetaData
if [ $RCartistfrommeta = "YES" ]; then
	artistName=$(plutil -key artistName "$AppPath/iTunesMetadata.plist" 2> /dev/null)
	artistNameAlpha=$(echo -n "$artistName" | tr -cd "[:alnum:]")
	# At least some alphanum inside ?
	if [ "$artistNameAlpha" != "" ]; then
		# Convert from unicode to human
		unicode=$artistName
		UnicodeToHuman
		AppDisplayName="$AppDisplayName [$human]"
	fi
fi

# Getting iTunes URL for AppAddict Submission

# echo "Locating iTunes URL..."
# iurl=http://itunes.apple.com/app/id$(plutil -#key itemId "$AppPath/iTunesMetadata.plist" 2> #/dev/null)
# if [ -z $iurl ]; then
#	 echo "ERROR! Failed To Find iTunes #URL!"
# fi

# Show the real human name of the app
echo "${Meter5}$AppDisplayName"


# Dealing with version numbers
AppVer=$(plutil -key CFBundleVersion "$tempLoc/Info.plist" 2> /dev/null | tr -d "\n\r")
AppShortVer=$(plutil -key CFBundleShortVersionString "$tempLoc/Info.plist" 2> /dev/null | tr -d "\n\r")
if [ ! "$AppShortVer" = "" ]; then
	if [ ! "$AppShortVer" = "$AppVer" ]; then
		AppVer="$AppShortVer v$AppVer"
	fi
fi
MinOS=$(plutil -key MinimumOSVersion "$tempLoc/Info.plist" 2> /dev/null | tr -d ".")
if [ "$MinOS" = "" ]; then
	echo "${Meter7}${escYellow}$MsgWarning:${escReset} unable to get MinOS"
	MinOS="000"
fi

Patched=""
Extras=""
ExtrasMatos=""
ExtrasAslr=""

# Does it need at least an iPhone3GS ?
Required=$(plutil -key 'UIRequiredDeviceCapabilities' "$tempLoc/Info.plist" 2> /dev/null)
if [ ! -z "$(echo "$Required" | grep -e "armv7" -e "opengles-2")" ]; then
	ExtrasMatos=" 3GS"
fi
# Does it need at least an iPhone4 ?
if [ ! -z "$(echo "$Required" | grep -e "front-facing-camera" -e "gyroscope")" ]; then
	ExtrasMatos=" iPhone4"
fi
# Does it need at least an iPhone4S ?
if [ ! -z "$(echo "$Required" | grep -e "bluetooth-le")" ]; then
	ExtrasMatos=" iPhone4S"
fi

# Is it iPad compatible only ? Or universal ?
iPad=$(plutil -key 'UIDeviceFamily' "$tempLoc/Info.plist" 2> /dev/null)
if [ ! -z "$iPad" ]; then
	if [ -z "$(echo "$iPad" | grep -e "1")" ]; then
		ExtrasMatos=" iPad"
		# Does it need at least an iPad2 ?
		if [ ! -z "$(echo "$Required" | grep -e "video-camera")" ]; then
			ExtrasMatos=" iPad2"
		fi
	else
		if [ ! -z "$(echo "$iPad" | grep -e "2")" ]; then
			ExtrasMatos="$ExtrasMatos Univ"
		fi
	fi
fi

# Creating temporary directory
if [ $RCverbose = "YES" ]; then
	echo -n "${Meter10}$MsgCreDire "
fi
WorkDir="/tmp/RC-$(date +%Y%m%d-%H%M%S)"
NewAppDir="$HOME/Documents/Cracked"
if [ -e "$WorkDir" ]; then
	rm -rf "$WorkDir"
fi
mkdir -p "$WorkDir"
if [ ! -e "$NewAppDir" ]; then
	mkdir -p "$NewAppDir"
fi
mkdir -p "$WorkDir/$AppName"
if [ ! -d "$WorkDir" -o ! -d "$NewAppDir" -o ! -d "$WorkDir/$AppName" ]; then
	echo "failed ! Directories not created"
	return 1
fi

# Copying executable (with attributes) to temporary space
if [ $RCverbose = "YES" ]; then
	echo "${Meter15}$MsgCopExec"
fi

foo=$( cp -a "$AppPath/$AppName/$AppExec" "$WorkDir/$AppName/" 2>&1> /dev/null )
if [ ! -e "$WorkDir/$AppName/$AppExec" ]; then
	echo "Unable to copy application files"
	rm -fr "$WorkDir"
	return 1
else
	# Disk full ?
	if [ $(stat -c%s "$WorkDir/$AppName/$AppExec") != $(stat -c%s "$AppPath/$AppName/$AppExec") ]; then
		echo "${escRed}$MsgDskFull ?${escReset}"
		rm -fr "$WorkDir"
		return 1
	fi
fi

if [ $RCverbose = "YES" ]; then
	echo -n "${Meter20}$MsgAnaAppl: "
fi

# Looking for fat's magic numbers (CafeBabe)
CafeBabeIsFat=$(dd bs=4 count=1 skip=0 if="$WorkDir/$AppName/$AppExec" 2> /dev/null | od -A n -t x1 -v | grep "ca fe ba be")

# Thin is very easy...
if [ ! "$CafeBabeIsFat" ]; then
	if [ $RCverbose = "YES" ]; then
		echo "${Meter25}Thin Binary found"
	fi
	# Thin binary = crack it easy
	CrackFunction
	RetRet=$?
	if [ $RetRet != 0 ]; then
		echo "${escRed}Error:${escReset} problem encountered in CrackFunction (Thin)"
		rm -fr "$WorkDir"
		return $RetRet
	fi

else

# Fat is very easy...
	if [ "$CafeBabeIsFat" ]; then
		if [ $RCverbose = "YES" ]; then
			echo "${Meter25}Fat Binary found"
		fi
		# Fat binary = crack it easy
		CrackFunction
		RetRet=$?
		if [ $RetRet != 0 ]; then
			echo "${escRed}Error:${escReset} problem encountered in CrackFunction (Fat)"
			rm -fr "$WorkDir"
			return $RetRet
		fi
	fi
fi

# Signing the application with 'ldone' (better than 'ldid').
if [ $RCverbose = "YES" ]; then
	echo "${Meter64}$MsgSgnAppl"
fi
foo=$(ldone "$WorkDir/$AppName/$AppExec" -s 2>&1> /dev/null)


# Timestamp-back executable to defeat checks
touch -r "$AppPath/$AppName/$AppExec" "$WorkDir/$AppName/$AppExec"

# Adding date
DayToday="$( date +%Y-%m-%d )"

# Adding credits file
if [ ! "$CrackerName" = "Anonymous" ]; then
	if [ $RCverbose = "YES" ]; then
		echo "${Meter65}Adding Credits"
	fi
		
#		if [ "$Crcommunity" = "aa"]; then
#		echo "Cracked by $CrackerName @AppAddict ($DayToday)" > "$WorkDir/$AppName/$CreditFile" 
#		fi
	
	echo "Cracked by $CrackerName ($DayToday)" > "$WorkDir/$AppName/$CreditFile"
	
	if [ ! -e "$AppPath/$AppName/$AppExec.crc" ]; then
		echo "CheckSum=$(echo -n "$CrackerName" | od -A n -t x1 -v | tr -d ' ','\n')" > "$WorkDir/$AppName/$AppExec.crc"
		touch -r "$AppPath/$AppName/$AppExec" "$WorkDir/$AppName/$AppExec.crc"
	fi
fi

#Extra AppAddict Credits /By tjglass/
#if [ "$Crcommunity" = "aa" ]; then
#	 echo "Adding Extra Credits..."
#	 touch -r #"$WorkDir/$AppName/_Required/cr.txt" #"/var/rasticrac/cracker.txt"
#	 echo "Added Extra Credits!"
#else
#	 echo "Extra Credits N/A!"
#fi

# Building .ipa (step 1)
mkdir -p "$WorkDir/Payload"
if [ ! -e "$WorkDir/Payload" ]; then
	echo "Failed to create Payload directory"
	rm -fr "$WorkDir"
	return 1
fi
mv "$WorkDir/$AppName" "$WorkDir/Payload/"

if [ $RCverbose = "YES" ]; then
	echo -n "${Meter66}$MsgCopArtw "
fi
if [ -e "$AppPath/iTunesArtwork" ]; then
	cp -a "$AppPath/iTunesArtwork" "$WorkDir/"
	# Timestamp ArtWork to protect cracker
	touch -r "$AppPath/$AppName/Info.plist" "$WorkDir/iTunesArtwork"
else
	echo "${Meter66}failed !"
fi

# Handling of CodeResources and friends. Timestamp them to protect cracker
cp -a "$AppPath/$AppName/Info.plist" "$WorkDir/Payload/$AppName/Info.plist"
mkdir "$WorkDir/Payload/$AppName/_CodeSignature"
cp "$AppPath/$AppName/_CodeSignature/CodeResources" "$WorkDir/Payload/$AppName/_CodeSignature/CodeResources"
touch -r "$AppPath/$AppName/Info.plist" "$WorkDir/Payload/$AppName/_CodeSignature/CodeResources"
if [ -e "$AppPath/$AppName/CodeResources" ]; then
	ln -s "_CodeSignature/CodeResources" "$WorkDir/Payload/$AppName/CodeResources"
	touch -h -r "$AppPath/$AppName/Info.plist" "$WorkDir/Payload/$AppName/CodeResources"
fi
if [ -e "$AppPath/$AppName/ResourceRules.plist" ]; then
	cp "$AppPath/$AppName/ResourceRules.plist" "$WorkDir/Payload/$AppName/ResourceRules.plist"
	touch -r "$AppPath/$AppName/Info.plist" "$WorkDir/Payload/$AppName/ResourceRules.plist"
fi

# Faking MetaData
if [ $RCverbose = "YES" ]; then
	if [ $RCmetadata = "YES" ]; then
		echo "${Meter69}$MsgFakMeta"
	else
		echo "${Meter69}$MsgNotMeta"
	fi
fi
if [ "$CrackerName" = "Anonymous" ]; then
	CrackedBy="AppAddict@apple.com"
else
	CrackedBy="$CrackerName@AppAddict.by"
	echo "${Patched}RC$CrackerName" | tr -cd "[:alnum:]" | tr "[A-Z][a-z][1-9]" "[1-9][a-z][A-Z]" > "$WorkDir/Payload/$AppName/_CodeSignature/ResourceRules"
	touch -r "$AppPath/$AppName/Info.plist" "$WorkDir/Payload/$AppName/_CodeSignature/ResourceRules"
fi

touch -r "$AppPath/$AppName/Info.plist" "$WorkDir/Payload/$AppName/_CodeSignature"

if [ -e "$AppPath/iTunesMetadata.plist" ]; then
	cp "$AppPath/iTunesMetadata.plist" "$WorkDir/iTunesMetadataSource.plist"
else
	echo "${Meter69}${escRed}Error:${escReset} problem with MetaData !"
	plutil -create "$WorkDir/iTunesMetadataSource.plist" 2>&1> /dev/null
fi

# Convert to pure text (if binary plist)
plutil -xml "$WorkDir/iTunesMetadataSource.plist" 2>&1> /dev/null
# Remove unwanted keys and subkeys
plutil -remove -key 'com.apple.iTunesStore.downloadInfo' "$WorkDir/iTunesMetadataSource.plist" 2>&1> /dev/null
plutil -remove -key 'asset-info' "$WorkDir/iTunesMetadataSource.plist" 2>&1> /dev/null
plutil -remove -key 'is-purchased-redownload' "$WorkDir/iTunesMetadataSource.plist" 2>&1> /dev/null
# Building lines
echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" > "$WorkDir/iTunesMetadata.plist"
echo "<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">" >> "$WorkDir/iTunesMetadata.plist"
echo "<plist version=\"1.0\">" >> "$WorkDir/iTunesMetadata.plist"
echo "<dict>" >> "$WorkDir/iTunesMetadata.plist"
grep -A99 "<key>UIRequiredDeviceCapabilities</key>" "$WorkDir/iTunesMetadataSource.plist" | grep -m1 -B99 "</dict>" >> "$WorkDir/iTunesMetadata.plist"
echo -e "\t<key>appleId</key>" >> "$WorkDir/iTunesMetadata.plist"
echo -e "\t<string>$CrackedBy</string>" >> "$WorkDir/iTunesMetadata.plist"
echo -e "\t<key>purchaseDate</key>" >> "$WorkDir/iTunesMetadata.plist"
echo -e "\t<date>2013-07-07T07:07:07Z</date>" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>artistId</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>artistName</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>bundleDisplayName</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>bundleShortVersionString</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>bundleVersion</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>buy-only</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>buyParams</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>copyright</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>drmVersionNumber</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>fileExtension</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>gameCenterEnabled</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>gameCenterEverEnabled</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 -m1 "<key>genre</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 -m1 "<key>genreId</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>itemId</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>itemName</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>kind</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>playlistArtistName</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>playlistName</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>price</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>priceDisplay</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>product-type</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A99 "<key>rating</key>" "$WorkDir/iTunesMetadataSource.plist" | grep -m1 -B99 "</dict>" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>releaseDate</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>s</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>software-type</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>softwareIcon57x57URL</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>softwareIconNeedsShine</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A99 "<key>softwareSupportedDeviceIds</key>" "$WorkDir/iTunesMetadataSource.plist" | grep -m1 -B99 "</array>" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>softwareVersionBundleId</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>softwareVersionExternalIdentifier</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A99 "<key>softwareVersionExternalIdentifiers</key>" "$WorkDir/iTunesMetadataSource.plist" | grep -m1 -B99 "</array>" >> "$WorkDir/iTunesMetadata.plist"
grep -A99 "<key>subgenres</key>" "$WorkDir/iTunesMetadataSource.plist" | grep -m1 -B99 "</array>" >> "$WorkDir/iTunesMetadata.plist"
# ???? <key>transitGeoFileURL</key><string>
grep -A1 "<key>vendorId</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
grep -A1 "<key>versionRestrictions</key>" "$WorkDir/iTunesMetadataSource.plist" >> "$WorkDir/iTunesMetadata.plist"
echo "</dict>" >> "$WorkDir/iTunesMetadata.plist"
echo -e "</plist>\n" >> "$WorkDir/iTunesMetadata.plist"
# Timestamp Metadata to protect cracker
touch -r "$AppPath/$AppName/Info.plist" "$WorkDir/iTunesMetadata.plist"

# Check for possible iTunesMetadata format changes
rm -f /tmp/diff.txt
diff "$WorkDir/iTunesMetadataSource.plist" "$WorkDir/iTunesMetadata.plist" > /tmp/diff.txt
rm -f "$WorkDir/iTunesMetadataSource.plist"
NewFields=$(wc -l /tmp/diff.txt | cut -f 1 -d " ")
if [ $NewFields -ne "11" -a $NewFields -ne "7" ]; then
	echo "${Meter70}${escYellow}$MsgWarning:${escReset} $MsgWrnMeta ?"
	#BEGIN DEBUG
	#echo "( $NewFields )"
	#cat /tmp/diff.txt
	#END DEBUG
fi
rm -f /tmp/diff.txt

# OLD Metadata Code
#if [ ! $RCmetadata = "YES" ]; then
#	mv "$WorkDir/iTunesMetadata.plist" "$WorkDir/iTunesMetadata$RCmetadatafilename.plist"
#
#fi

# Want Extras in filename ?
if [ $RCextras = "YES" ]; then
	Extras="$ExtrasMatos$ExtrasAslr"
fi

# Building IPA name, adding AppVersion and MinOsVersion, adding CrackerName
if [ "$CrackerName" = "Anonymous" ]; then
	CrackedBy=""
	ZipComment="Rasticrac 3.1a5 for AppAddict ($DayToday) $Patched"
else
	CrackedBy="-$CrackerName"
	ZipComment="Cracked By $CrackerName with Rasticrac 3.1a5 For AppAddict ($DayToday) $Patched"
fi

# Cutting too long app name
AppDisplayName=${AppDisplayName:0:200}

 IPAName="$NewAppDir/$AppDisplayName (v$AppVer$Extras$Patched os$MinOS)$CrackedBy.rc31a5_AppAddict.ipa"

# If debug-check-only, don't create real Ipa but an empty proof file
if [ $RCcheck = "YES" ]; then
	#DEBUG# ls -l "$WorkDir/$AppName/$AppExec"
	printf -v CRC '%x' $(cksum "$WorkDir/Payload/$AppName/$AppExec" | cut -f 1 -d ' ')
	touch "$IPAName.$CRC.checked"
	echo "${Meter100}${escGreen}Check:${escReset} $AppDisplayName (v$AppVer$Extras$Patched os$MinOS)."
	rm -fr "$WorkDir"
	echo "$tempLoc" >> /var/mobile/.cracked.log
	MenuOK=$(($MenuOK + 1))
	return 0
fi

#DEBUG
#FreeSize=$(df -m "$NewAppDir/" | grep disk | awk '{print $4}')
#echo "${Meter74}Debug: free size on device    [$FreeSize M$MsgSizUnit]"
#DEBUG

# Size of first data to compress
FirstSize=$(du -m -s "$WorkDir" | cut -f 1)
echo "${Meter75}$MsgZipStep 1) [$FirstSize M$MsgSizUnit]"

# Timestamping
touch -r "$AppPath/$AppName/Info.plist" "$WorkDir/Payload/$AppName"
touch -r "$AppPath/$AppName/Info.plist" "$WorkDir/Payload"

cd "$WorkDir"
rm -f "$IPAName"
rm -f "$IPAName.temp"
# Script version number in zip's comment
# Faster ipa thanks to smart files order (?)
ZipError=$( echo "$ZipComment" | zip $RCcompression -z -y -m -r "$IPAName.temp" "Payload/$AppName/Info.plist" iTunesMetadata$RCmetadatafilename.plist iTunesArtwork Payload  2>&1> /dev/null )
cd "$PwdPwd" 2>&1> /dev/null

if [ ! -z "$ZipError" ]; then
	echo "${Meter76}${escRed}ZipError${escReset}: \"$( echo "$ZipError" | tr -d "\t\n" )\""
fi

if [ ! -e "$IPAName.temp" ]; then
	echo "${escRed}Failed to compress the .ipa${escReset}"
	rm -fr "$WorkDir"
	return 1
fi

# Remember size of .ipa after step 1
ZipSize=$(stat -c%s "$IPAName.temp")

# Building .ipa (step 2)
# Using a SymbolicLink pointing to App Directory
ln -s "$AppPath/" "$WorkDir/Payload"

#DEBUG
#FreeSize=$(df -m "$NewAppDir/" | grep disk | awk '{print $4}')
#echo "${Meter74}Debug: free size on device    [$FreeSize M$MsgSizUnit]"
#DEBUG

# Size of other data to compress
SecondSize=$(du -m -s "$AppPath" | cut -f 1)
echo "${Meter80}$MsgZipStep 2) [$(( $SecondSize - $FirstSize )) M$MsgSizUnit]"

cd "$WorkDir"
# Zip doesn't move/delete source, and excludes some unwanted files. Smart "-n" flag excludes already compact files.
ZipError=$( zip $RCcompression -u -y -r -n .jpg:.JPG:.jpeg:.png:.PNG:.gif:.GIF:.Z:.gz:.zip:.zoo:.arc:.lzh:.rar:.arj:.mp3:.mp4:.m4a:.m4v:.ogg:.ogv:.avi:.flac:.aac \
	"$IPAName.temp" Payload/* -x Payload/iTunesArtwork Payload/iTunesMetadata.plist "Payload/Documents/*" "Payload/Library/*" "Payload/tmp/*" "Payload/$AppName/$AppExec" "Payload/$AppName/SC_Info/*" "Payload/$AppName/_CodeSignature/*" "Payload/$AppName/CodeResources" "Payload/$AppName/ResourceRules.plist" "Payload/$AppName/Info.plist" 2>&1> /dev/null )
## */

if [ ! -z "$ZipError" ]; then
	echo "${Meter81}${escRed}ZipError${escReset}: \"$( echo "$ZipError" | tr -d "\t\n" )\""
fi

# It failed because disk is full (zip size after Part[2] is still the same)
if [ $(stat -c%s "$IPAName.temp") -eq $ZipSize ]; then
	echo "${escRed}$MsgIpaInco ! $MsgDskFull ?${escReset}"
	rm -f "$IPAName.temp"
	rm -fr "$WorkDir"
	return 1
fi

# Ipa final name
mv "$IPAName.temp" "$IPAName"

# Removing SymbolicLink
rm "$WorkDir/Payload"
cd "$PwdPwd" 2>&1> /dev/null

# Removing temporary directory
if [ $RCverbose = "YES" ]; then
	echo "${Meter98}$MsgRemTemp"
fi
rm -rf "$WorkDir"

# Cracked app is added into the already-cracked apps list
echo "$tempLoc" >> /var/mobile/.cracked.log


# Displaying finished Ipa details
ZipSize=$(du -m -s "$IPAName" | cut -f 1)
echo "${Meter100}${escGreen}$MsgIpaDone${escReset} \"$IPAName\" [$ZipSize M$MsgSizUnit]"

MenuOK=$(($MenuOK + 1))
}

# End Core Function
# ======




# ======
# Begin script main part

# Origin's directory
PwdPwd="$PWD"

# Select texts' language
SelectLanguage

# Votez Martine !
if [ ! -e /bin/ps ]; then
	echo "$MsgCntFind 'ps'. $MsgInsCydi: 'adv-cmds'"
	exit 1
fi

# Is this script running inside a GUI ?
# (ie: parent process runs from "/Applications/xxx.app")
if [ ! "$(ps -e | grep "$PPID" | grep "/Applications/.*\.app/")" = "" ]; then
	RCinaGUI="YES"
fi

# Initialize progress meter labels (for GUI)
if [ $RCinaGUI = "YES" ]; then
	export TERM="xterm"
	for ((i=0;i<=100;i++)); do
		export Meter$i="$i% "
	done
else
	# Not in a GUI
#	clear
	echo ""

	# If output is not a terminal (ie: redirected to a file, etc), don't display colors/etc
	if [[ -t 1 ]]; then
		# Escape codes
		esc="$( echo -ne "\033" )"
		escReset="${esc}[0m"
		escUnder="${esc}[4m"
		escBlue="${esc}[34m"
		escGreen="${esc}[32m"
		escRed="${esc}[31m"
		escYellow="${esc}[33m"
		escPurple="${esc}[35m"
		escCyan="${esc}[36m"
	fi

	# Terminal misconfigured
	if [ -z "$TERM" ]; then
		echo "${escYellow}$MsgWarning:${escReset} your \$TERM is not set"
		export TERM="xterm"
	fi

	# MobileTermBackgrounder is used = problems
	if [ "$TERM" = "screen" ]; then
		#echo "${escYellow}$MsgWarning:${escReset} your \$TERM is 'screen'"
		export TERM="xterm"
		export TERM="vt100"
	fi

	# Screen width
	if [ ! -e /usr/bin/tput ]; then
		echo "$MsgCntFind 'tput'"
		exit 1
	fi
	Cols=$(tput cols)

	# Progress bars full width
	BarCols=$(( $Cols - 8 ))
	while [ ${#RCxxx} -lt $BarCols ]
	do
		RCxxx="$RCxxx$RCxxx"
		RCsss="$RCsss$RCsss"
	done
fi

echo "${Meter0}*** ${escUnder}Rasticrac v3.1a5${escReset} ***"

AltDump="NO"

if [ ! -e /usr/bin/plutil ]; then
	echo "$MsgCntFind 'plutil'. $MsgInsCydi: 'Erica Utils'"
	exit 1
fi

if [ ! -e /var/root/dumpdecrypted.dylib ]; then
	echo "$MsgCntFind 'dumpdecrypted.dylib'."
	exit 1
fi

if [ ! -e /usr/bin/otool ]; then
	echo "$MsgCntFind 'otool'. $MsgInsCydi: 'Darwin CC Tools'"
	exit 1
fi

if [ ! -e /usr/bin/ldone ]; then
	echo "$MsgCntFind 'ldone'. $MsgInsCydi"
	exit 1
fi
if [ ! -x /usr/bin/ldone ]; then
	echo "Please 'chmod 777 /usr/bin/ldone'"
	exit 1
fi

if [ ! -e /bin/touch ]; then
	echo "$MsgCntFind 'touch'"
	exit 1
fi

if [ ! -e /usr/bin/zip ]; then
	echo "$MsgCntFind 'zip'"
	exit 1
fi

if [ ! -e /usr/sbin/sysctl ]; then
	echo "$MsgCntFind 'sysctl'"
	exit 1
fi

if [ ! -e /usr/bin/basename ]; then
	echo "$MsgCntFind 'basename'"
	exit 1
fi

if [ ! -e /usr/bin/cut ]; then
	echo "$MsgCntFind 'cut'"
	exit 1
fi

if [ ! -e /usr/bin/awk ]; then
	echo "$MsgCntFind 'awk'. $MsgInsCydi: 'Gawk'"
	exit 1
fi

# iDevice's type of CPU
CPUType=$(sysctl hw.cpusubtype | awk '{print $2}')

# iDevice's iOS version
iOSver=$(plutil -key ProductVersion /System/Library/CoreServices/SystemVersion.plist 2> /dev/null | tr -d ".")
echo "${Meter1}${escYellow}Note:${escReset} running iOS$iOSver on '$CPUType' cpu"

# Workaround for iOS6
if [ ${iOSver:0:1} -gt 5 ]; then
	AltDump="YES"
fi

# Convert compatible CpuType
if [ $CPUType = "10" ]; then
	CPUType="9"
fi
if [ $CPUType != "6" -a $CPUType != "9" -a $CPUType != "11" ]; then
	echo "${escRed}STOP:${escReset} can't handle this cpu yet !"
	exit 1
fi

# Cydia's "Speak" tool is needed for speech support
if [ ${iOSver:0:1} -lt 4 ]; then
	RCspeak="NO"
fi
if [ $RCspeak = "YES" ]; then
	if [ ! -e /usr/bin/speak ]; then
		echo "${Meter3}${escYellow}Note:${escReset} install 'Speak' from Cydia for speech"
		RCspeak="NO"
	fi
fi

if [ ! -e /usr/bin/head ]; then
	echo "$MsgCntFind 'head'"
	exit 1
fi

if [ ! -e /usr/bin/tail ]; then
	echo "$MsgCntFind 'tail'"
	exit 1
fi

# Create an empty public memory file
if [ ! -e /var/mobile/.cracked.log ]; then
	touch /var/mobile/.cracked.log
	chmod 666 /var/mobile/.cracked.log
fi

# Don't want MetaData ? It sucks !
if [ ! $RCmetadata = "YES" ]; then
	echo "${Meter3}${escYellow}Note:${escReset} MetaData='NO' is not recommended"
	RCmetadatafilename=".backup"
fi

# Is syslog available ?
if [ ! -e /usr/sbin/syslogd ]; then
	echo "${Meter3}${escYellow}Note:${escReset} should install 'syslogd' from Cydia"
fi
if [ ! -e /usr/bin/logger ]; then
	echo "${Meter4}${escYellow}Note:${escReset} should install 'logger' from Cydia (inetutils)"
fi

if [ ! $RCinaGUI = "YES" ]; then
	# Get and store the encrypted apps list
	rm -f /tmp/lsd.tmp

	# Why is that slower than next code ???
	#ls -d /var/mobile/Applications/*/*.app/SC_Info 2> /dev/null | sort -f -t \/ -k 6 | while read OneApp
	## */
	#do
	#	echo "$(dirname "$OneApp")" >> /tmp/lsd.tmp
	#done

	# Why is that faster than previous code ???
	ls -d /var/mobile/Applications/*/*.app 2> /dev/null | sort -f -t \/ -k 6 | while read OneApp
	## */
	do
		if [ -d "$OneApp/SC_Info" ]; then
			echo "$OneApp" >> /tmp/lsd.tmp
		fi
	done
fi

# Loop through the different flags
LoopExit="NO"
while [ $LoopExit = "NO" ]
do
	LoopExit="YES"
	# Secret "alternative dumping" flag
	if [ "$1" = "-a" ]; then
		shift
		echo "$MsgAltMeth"
		AltDump="YES"
		LoopExit="NO"
	fi

	# Verbose mode flag
	if [ "$1" = "-v" ]; then
		shift
		RCverbose="YES"
		LoopExit="NO"
	fi

	# Secret "check only" flag
	if [ "$1" = "-chk" ]; then
		shift
		RCcheck="YES"
		LoopExit="NO"
	fi

	# Secret "LamerPatcher Off" flag
	if [ "$1" = "-lpoff" ]; then
		shift
		RClamestpatchest="NO"
		LoopExit="NO"
	fi

	# Secret "Extras Off" flag
	if [ "$1" = "-extoff" ]; then
		shift
		RCextras="NO"
		LoopExit="NO"
	fi

	# Secret "Speak Off" flag
	if [ "$1" = "-spkoff" ]; then
		shift
		RCspeak="NO"
		LoopExit="NO"
	fi

	# Secret "Artist Off" flag
	if [ "$1" = "-artoff" ]; then
		shift
		RCartistfrommeta="NO"
		LoopExit="NO"
	fi

	# Secret "Compression Ratio" flag
	if [ "$1" = "-2" -o "$1" = "-3" -o "$1" = "-4" -o "$1" = "-5" -o "$1" = "-6" -o "$1" = "-7" -o "$1" = "-8" -o "$1" = "-9" ]; then
		RCcompression="$1"
		shift
		echo "${Meter5}${escYellow}Note:${escReset} will now use Compression Ratio '$RCcompression'"
		LoopExit="NO"
	fi
done

# No more argument: display help
if [ $# -lt 1 ]; then
	if [ ! $RCinaGUI = "YES" ]; then
		# The "-a" flag is not displayed in the help, but it does exist.
		scr=$(basename $0)
		echo "List/Help: $scr"
		echo "	   Menu: $scr [-v] -m [CN [CFN]]"
		echo " CrackAll: $scr [-v] -all [CN [CFN]]"
		echo " CrackOne: $scr [-v] AN [CN [CFN]]"
		echo " MarkDone: $scr -mark"
		echo "ResetDone: $scr -zero"
		echo
		echo "AN=AppName CN=CrackerName CFN=CreditFileName"
		echo
		if [ -e /tmp/lsd.tmp ]; then
			cat /tmp/lsd.tmp | cut -f 6 -d '/' | sed "s:\\.app:,:" | tr "\n" " "
			echo -e "\010\010."
			rm -f /tmp/lsd.tmp
		fi
		exit 1
	else
		echo "Missing argument !"
		exit 2
	fi
fi

# Erasing memory file
if [ "$1" = "-zero" ]; then
	echo "$MsgEraMemo"
	# Don't use rm
	cp /dev/null /var/mobile/.cracked.log 2>&1> /dev/null
	rm -f /tmp/lsd.tmp
	exit 1
fi

# Marking all apps as done in memory file
if [ "$1" = "-mark" ]; then
	echo "$MsgMarDone"
	if [ -e /tmp/lsd.tmp ]; then
		cp /tmp/lsd.tmp /var/mobile/.cracked.log 2>&1> /dev/null
		rm -f /tmp/lsd.tmp
	else
		cp /dev/null /var/mobile/.cracked.log 2>&1> /dev/null
	fi
	exit 1
fi

# Only if 'root'
if [ $(id -u) = 0 ]; then
	vm1="/System/Library/LaunchDaemons/com.apple.dynamic_pager.plist"
	vm2="/Library/Preferences/com.apple.virtualMemory.plist"
	# Create a swapfile
	if [ "$1" = "-swapon" ]; then
		echo "Creating a swapfile..."
		if [ ! -e "$vm1" ]; then
			if [ ! -e "$vm2" ]; then
				echo "Creating..."
				echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"><plist version=\"1.0\"><dict>\
					<key>KeepAlive</key><true/><key>Label</key><string>com.apple.dynamic_pager</string><key>OnDemand</key><false/><key>ProgramArguments</key>\
					<array><string>/sbin/dynamic_pager</string><string>-F</string><string>/private/var/vm/swapfile</string></array><key>RunAtLoad</key><true/></dict></plist><key>UseEncryptedSwap</key><false/>" > $vm1
				chmod 755 $vm1
				plutil -xml $vm1 2>&1> /dev/null
				echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?><!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\"><plist version=\"1.0\"><dict>\
					<key>UseEncryptedSwap</key><false/></dict></plist>" > $vm2
				chmod 755 $vm2
				plutil -xml $vm2 2>&1> /dev/null
				chmod 777 /var/vm
				echo "Reboot needed..."
				sync
				reboot
				exit 2
			fi
		fi
		exit 1
	fi
	# Remove the swapfile
	if [ "$1" = "-swapoff" ]; then
		echo "Removing the swapfile..."
		if [ -e "$vm1" ]; then
			if [ -e "$vm2" ]; then
				echo "Removing..."
				rm -f $vm1
				rm -f $vm2
				echo "Reboot needed..."
				sync
				reboot
				exit 2
			fi
		fi
		exit 1
	fi
	vm1=""
	vm2=""
fi

if [ ! $RCinaGUI = "YES" ]; then
	MenuAsked=0
	MenuFound=0
	MenuOK=0
	MenuError=0
	MenuErrorList=""

	# Berzerk mode: cracking all apps
	if [ "$1" = "-all" ]; then
		echo -n "$MsgBrzMode !"
		if [ -e /tmp/lsd.tmp ]; then
			# ("grep -vf" is sloooow. Use "-Fvf")
			# Removing already-done from full apps list
			tempgrep=$(mktemp)
			grep -Fvf /var/mobile/.cracked.log /tmp/lsd.tmp > $tempgrep
			MenuAsked=$(cat $tempgrep | wc -l)
			ProgressTarget=$MenuAsked
			ProgressDone=0
			echo " ($MenuAsked)"
			echo

			if [ $RCbarSize = "YES" -a $MenuAsked != 0 ]; then
				ProgressTargetSize=0
				ProgressDoneSize=0
				echo -n "Computing total size"
				# (Don't use a pipe for the while loop)
				while read OneApp
				do
					# Size of the app, till dawn.
					AppSize=$( du -s -k "$OneApp" | cut -f 1 )
					ProgressTargetSize=$(($ProgressTargetSize + $AppSize))
					echo -n "."
				done < $tempgrep
				echo
				echo
			fi

			# (Don't use a pipe for the while loop)
			while read OneApp
			do
				ProgressDone=$(($ProgressDone + 1))
				echo -n "${escPurple}($ProgressDone/$ProgressTarget)${escReset} "

				if [ $RCbarSize = "YES" ]; then
					# Size of the app, till dawn.
					AppSize=$( du -s -k "$OneApp" | cut -f 1 )
					ProgressDoneSize=$(($ProgressDoneSize + $AppSize))
				fi

				CoreFunction "$OneApp" "$2" "$3"
				if [ $? = 1 ]; then
					if [ $RCspeak = "YES" ]; then
						su mobile -c "speak Error !" &
					fi
					MenuError=$(($MenuError + 1))
					if [ -z "$MenuErrorList" ]; then
						MenuErrorList="${OneApp:62:$(( ${#OneApp} - 66 ))}"
					else
						MenuErrorList="$MenuErrorList, ${OneApp:62:$(( ${#OneApp} - 66 ))}"
					fi
				fi

				DisplayBars
				echo
			done < $tempgrep
			rm -f $tempgrep
			rm -f /tmp/lsd.tmp
		else
			echo " ($MsgBrzNoth)"
		fi

		echo "$MsgWasAskd:all ($MenuAsked)  $MsgFoundIt:$MenuFound  $MsgErrrors:$MenuError  OK:$MenuOK."
		if [ ! -z "$MenuErrorList" ]; then
			echo "$MsgErrrors: $MenuErrorList."
		fi

		if [ $RCspeak = "YES" ]; then
			su mobile -c "speak Terminated." &
		fi

		exit 1
	else
		# Menu mode: displaying menu and processing user choices
		if [ "$1" = "-m" ]; then
			if [ -e /tmp/lsd.tmp ]; then
				echo -n "$MsgBldMenu"
				rm -f /tmp/lsdmenu.tmp
				touch /tmp/lsdmenu.tmp
				rm -f /tmp/lsddisp.tmp
				# Array with all the letters
				Letters=( $( echo {a..z} {a..z}{a..z} ) )
				# Search for best columns size
				BestFiller=666
				BestFound=666
				for (( i=18;i<=30;i++)); do
					FillerFound=$(( $Cols % $i ))
					if [ $FillerFound -lt $BestFiller ]; then
						BestFiller=$FillerFound
						BestFound=$i
						if [ $FillerFound = 0 ]; then
							break
						fi
					fi
				done
				LongNames=$(( $BestFound - 3 ))
				ShortNames=$(( $LongNames - 1 ))

				# Using 'real name' in menu ?
				if [ $RCrealnamemenu = "YES" ]; then
					tempfile=$(mktemp)
					templist=$(mktemp)
					# Using 'list of installed apps' from SpringBoard as source for real names
					cp /var/mobile/Library/Caches/com.apple.mobile.installation.plist $tempfile
					plutil -xml $tempfile 2>&1> /dev/null
					cat $tempfile | grep -F -e "<key>CFBundleDisplayName</key>" -e "<key>Container</key>" -A1 | tr -d "\t" > $templist
					rm $tempfile
				fi

				Letter=0
				LineLength=$Cols
				# ("grep -vf" is sloooow. Use "-Fvf")
				# Removing already-done from full apps list
				grep -Fvf /var/mobile/.cracked.log /tmp/lsd.tmp | while read OneApp
				do
					GoodLetter=${Letters[$Letter]}

					# Using 'real name' in menu ?
					if [ $RCrealnamemenu = "YES" ]; then
						unicode="$( cat $templist | grep "${OneApp:0:61}" -B3 | grep -m1 "<string>" | sed -e 's:<string>::g' -e 's:</string>::g' )"
						# If name is too exotic, use 'internal name'
						if [ "$(echo -n "$unicode" | tr -cd "[:alnum:]")" = "" ]; then
							unicode="${OneApp:62:$(( ${#OneApp} - 66 ))}"
						fi
						UnicodeToHuman
						OneOneApp="$human$RCdots"
					else
						OneOneApp="${OneApp:62:$(( ${#OneApp} - 66 ))}$RCdots"
					fi

					if [ $Letter -lt 26 ]; then
						echo -n "${escPurple}$GoodLetter:${escReset}${OneOneApp:0:$LongNames} " >> /tmp/lsddisp.tmp
						echo "\"$GoodLetter\"$OneApp" >> /tmp/lsdmenu.tmp
						LineLength=$(( $LineLength - $LongNames - 3 ))
					else
						echo -n "${escPurple}$GoodLetter:${escReset}${OneOneApp:0:$ShortNames} " >> /tmp/lsddisp.tmp
						echo "\"$GoodLetter\"$OneApp" >> /tmp/lsdmenu.tmp
						LineLength=$(( $LineLength - $ShortNames - 4 ))
					fi

					# End of line
					if [ $LineLength = $BestFiller ]; then
						echo "" >> /tmp/lsddisp.tmp
						LineLength=$Cols
					fi

					Letter=$(($Letter + 1))
					# Too much apps (max is 27*26 = 702)
					if [ $Letter = 702 ]; then
						break
					fi
				done

				if [ $RCrealnamemenu = "YES" ]; then
					rm $templist
				fi

				# Other options
				echo -n "${escPurple}0:${escReset}${MskZroDone:0:$LongNames} " >> /tmp/lsddisp.tmp
				echo -n "${escPurple}9:${escReset}${MsgMrkDone:0:$LongNames} " >> /tmp/lsddisp.tmp

				# Displaying menu
				if [ -e /tmp/lsddisp.tmp ]; then
					echo
					clear
					echo "*** ${escUnder}Rasticrac v3.1a5 menu${escReset} ***"
					cat /tmp/lsddisp.tmp
					rm -f /tmp/lsddisp.tmp
					echo
					read -p "$MsgYouChoi ? " YourChoices
					echo
					ProgressTarget=$( echo $YourChoices | wc -w )
					ProgressDone=0

					if [ $RCbarSize = "YES" -a $ProgressTarget != 0 ]; then
						ProgressTargetSize=0
						ProgressDoneSize=0
						echo -n "Computing total size"

						# Do all these choices
						for OneChoice in $YourChoices
						do
							if [ ! "$OneChoice" = "0" ]; then
								if [ ! "$OneChoice" = "9" ]; then
									tempLoc=$(grep -i "\"$OneChoice\"" /tmp/lsdmenu.tmp | cut -f 3 -d "\"")
									if [ ! -z "$tempLoc" ]; then
										AppCount=$(echo "$tempLoc" | wc -l)
										if [ $AppCount = 1 ]; then
											# Size of the app, till dawn.
											AppSize=$( du -s -k "$tempLoc" | cut -f 1 )
											ProgressTargetSize=$(($ProgressTargetSize + $AppSize))
											echo -n "."
										fi
									fi
								fi
							fi
						done
						echo
						echo

						# Nothing to do; no need for progress
						if [ $ProgressTargetSize = 0 ]; then
							RCbarSize="ZERO"
						fi
					fi

					# Do all these choices
					for OneChoice in $YourChoices
					do
						ProgressDone=$(($ProgressDone + 1))
						echo -n "${escPurple}($ProgressDone/$ProgressTarget)${escReset} "
						MenuAsked=$(($MenuAsked + 1))
						if [ "$OneChoice" = "0" ]; then
							echo "$MsgEraMemo"
							# Don't use rm
							cp /dev/null /var/mobile/.cracked.log 2>&1> /dev/null
							MenuAsked=$(($MenuAsked - 1))
						else
							if [ "$OneChoice" = "9" ]; then
								echo "$MsgMarDone"
								cp /tmp/lsd.tmp /var/mobile/.cracked.log 2>&1> /dev/null
								MenuAsked=$(($MenuAsked - 1))
							else
								tempLoc=$(grep -i "\"$OneChoice\"" /tmp/lsdmenu.tmp | cut -f 3 -d "\"")
								if [ -z "$tempLoc" ]; then
									echo "$MsgWrgChoi ($OneChoice)"
								else
									AppCount=$(echo "$tempLoc" | wc -l)
									if [ $AppCount = 1 ]; then

										if [ $RCbarSize = "YES" ]; then
											# Size of the app, till dawn.
											AppSize=$( du -s -k "$tempLoc" | cut -f 1 )
											ProgressDoneSize=$(($ProgressDoneSize + $AppSize))
										fi

										CoreFunction "$tempLoc" "$2" "$3"
										if [ $? = 1 ]; then
											if [ $RCspeak = "YES" ]; then
												su mobile -c "speak Error !" &
											fi
											MenuError=$(($MenuError + 1))
											if [ -z "$MenuErrorList" ]; then
												MenuErrorList="${tempLoc:62:$(( ${#tempLoc} - 66 ))}"
											else
												MenuErrorList="$MenuErrorList, ${tempLoc:62:$(( ${#tempLoc} - 66 ))}"
											fi
										fi
									else
										echo "$MsgBadChoi ($OneChoice = $AppCount)"
									fi
								fi
							fi
						fi

						DisplayBars
						echo

					done
					rm -f /tmp/lsdmenu.tmp

					if [ $RCspeak = "YES" ]; then
						su mobile -c "speak Finished." &
					fi

					echo
					echo "$MsgWasAskd:$MenuAsked  $MsgFoundIt:$MenuFound  $MsgErrrors:$MenuError  OK:$MenuOK."
					if [ ! -z "$MenuErrorList" ]; then
						echo "${escRed}$MsgErrrors:${escReset} $MenuErrorList."
					fi
				else
					echo " $MsgMnuEmpt !"
				fi
				rm -f /tmp/lsd.tmp
			else
				echo " $MsgMnuEmpt !"
			fi
			exit 1
		fi
	fi
fi

# Just one app to do
CoreFunction "$1" "$2" "$3"
#if [ $? = 1 ]; then
#	echo "Error: problem encountered."
#	exit 1
#fi

# Not needed anymore
rm -f /tmp/lsd.tmp


#
# Never gonna give you up, never gonna let you down, never gonna run around and desert you.
# Never gonna make you cry, never gonna say goodbye, never gonna tell a lie and hurt you.
#


#
# Thanks.
# Merci.
# Hontoni arigato.
#

# Thanks for using v3.1a5
