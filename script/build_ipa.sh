#! /bin/sh

#签名标示
SignIdentiy=$IPA_SignIdentiy
ProvisionIdentiy=$IPA_ProvisionIdentiy

#要生成的Target
Targets_Num=${#ProjectTargets_Array[@]}

# Smb
SmbServer=SambaServer
MountDirectory=/Dir/to/mount/samba

# Destinate
DestPath=$MountDirectory/ios
FileNameSuffix=`date +%F_%H.%M` 

function buildProject
{
	cd $XCodeProject_Path
    mount_smbfs //SmbUser:Passwd@$SmbServer $MountDirectory

	for((i=0;i<$Targets_Num;i++))
	do
		echo "====================>>>>> Start Generate IPA Success For Target: " ${ProjectTargets_Array[i]}
		echo "====================>>>>> Cleaning Before Build:"
		xcodebuild -configuration Release clean
		echo "====================>>>>> Clean Done !!!"

		echo "====================>>>>> Start Building Target: " ${ProjectTargets_Array[i]}
		xcodebuild -sdk iphoneos -jobs 4 -target ${ProjectTargets_Array[i]} -configuration Release CODE_SIGN_IDENTITY="$SignIdentiy" PROVISIONING_PROFILE="$ProvisionIdentiy"
		echo "====================>>>>> Build Target Done !!!"

		echo "====================>>>>> Starting Pack Target: " ${TargetOutputName_Array[i]}".ipa"
	    xcrun -sdk iphoneos PackageApplication -v  $TargetOutput_Path/${TargetOutputName_Array[i]}.app -o $TargetExport_Path/${TargetOutputName_Array[i]}.ipa --sign "$SignIdentiy"
		echo "====================>>>>> Pack Target Done !!!"
		echo "====================>>>>> Generate IPA " ${ProjectTargets_Array[i]}".ipa Succeed !!!"

		echo "-----------Start Coping IPA File to MySmb Server:  -------------"
        echo "FileNameSuffix is: "$FileNameSuffix
        DestFileName=$DestPath/${TargetOutputName_Array[i]}"("$FileNameSuffix").ipa"
        cp $TargetExport_Path/${TargetOutputName_Array[i]}.ipa $DestFileName
		echo "-----------Copy IPA File to MySmb Server Succeed!  -------------"
	done 
}
