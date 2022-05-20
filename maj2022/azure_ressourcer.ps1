# fileshare

$connectTestResult = 

Test-NetConnection -ComputerName filesharestorage20220516.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {

    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"filesharestorage20220516.file.core.windows.net`" /user:`"localhost\filesharestorage20220516`" /pass:`"BNXhNzH6i5EbOJ9QY/0HymLmdRxn1QkhwiyjNR8O3VhyT3JecVPfMsTG4DBrP+08mSy5l0BCaLaaQuHbvCqxBQ==`""
    # Mount the drive
    New-PSDrive -Name T -PSProvider FileSystem -Root "\\filesharestorage20220516.file.core.windows.net\marketing" -Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}


# blob storage

install-module az

Connect-AzAccount

# vi skal lave en storage account

get-command -noun AzStorageAccount

Get-AzStorageAccount

$ressourceGroup='dk'
$location='westeurope'
$dato = Get-Date -Format "yyyyMMdd"
        
New-AzResourceGroup -location $location -Name $ressourceGroup

#max 24 tegn
$storageAccountName="storageaccountsu$dato"
New-AzStorageAccount -ResourceGroupName $ressourceGroup -Name $storageAccountName -Location $location -Kind StorageV2 -SkuName Standard_GRS -AccessTier Cool

$DataLakeName="datalakesu$dato"
New-AzStorageAccount -Name $DataLakeName -SkuName Standard_LRS -ResourceGroupName $ressourceGroup -Location $location -Kind StorageV2 -AccessTier Cool -EnableHierarchicalNamespace $true

# upload some data 
$storageAccount=Get-AzStorageAccount -Name $storageAccountName -ResourceGroupName $ressourceGroup

$blobcontainerName='blobcontainer'
New-AzStorageContainer -Name $blobcontainerName -Context $storageAccount.Context -Permission Container

# upload some files
$folder="C:\DP203Kursus\data\images"
Set-Location $folder

$year=(Get-Date).Year
$month=Get-date -Format "MMMM"

Set-AzStorageBlobContent -File .\mtb.jpg -Container $blobcontainerName -BlobType Block -Context $storageAccount.Context -blob "images\products\$year\$month\mtb.jpg"
Set-AzStorageBlobContent -File .\forgaffel.jpg -Container $blobcontainerName -BlobType Block -Context $storageAccount.Context -StandardBlobTier hot -Blob "images\products\$year\$month\forgaffel.jpg"


# upload some data 
$storageAccount=Get-AzStorageAccount -Name $DataLakeName -ResourceGroupName $ressourceGroup

$datalakecontainerName='datalakecontainer'
New-AzStorageContainer -Name $datalakecontainerName -Context $storageAccount.Context -Permission Container

# upload some files
$folder="C:\DP203Kursus\data\aidata"
Set-Location $folder

$year=(Get-Date).Year
$month=Get-date -Format "MMMM"

$files= dir -File
foreach ($file in $files){
    $fileName=$file.Name
    Set-AzStorageBlobContent -File $fileName -Container $datalakecontainerName -BlobType Block -Context $storageAccount.Context -blob "aidata\information\$year\$month\$fileName"
}


# list blobcontainer content
$storageAccount=Get-AzStorageAccount -Name $storageAccountName -ResourceGroupName $ressourceGroup
Get-AzStorageBlob -Container $blobcontainerName -Context $storageAccount.Context | select name


# az cli kommando:
# az storage account list --query '[].{Name:name}' --output table

# list datalake container content

$storageAccount=Get-AzStorageAccount -Name $DataLakeName -ResourceGroupName $ressourceGroup
Get-AzStorageBlob -Container $datalakecontainerName -Context $storageAccount.Context |select name

# rasp
$datalakecontainerName='raspberry'
Get-AzStorageBlob -Container $datalakecontainerName -Context $storageAccount.Context |where name -like *csv | measure








