
# Update-Hitokoto.ps1

# 设置保存一言和标识符的文件路径
$storageFilePath = Join-Path $env:USERPROFILE 'hitokoto_storage.txt'

# 定义获取一言的函数
function Get-Hitokoto {
    $apiUrl = 'https://v1.hitokoto.cn/'
    $response = Invoke-RestMethod -Uri $apiUrl -Method Get
    return $response.hitokoto
}

# 生成新的标识符
$storedIdentifier = [Guid]::NewGuid().ToString()
$storedHitokoto = Get-Hitokoto

# 保存标识符和句子到文件
$dataToStore = @{
    Identifier = $storedIdentifier
    Hitokoto = $storedHitokoto
} | ConvertTo-Json
$dataToStore | Out-File -FilePath $storageFilePath -Force

Write-Host "Updated Hitokoto: $storedHitokoto" -ForegroundColor Green

